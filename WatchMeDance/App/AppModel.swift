import CoreMotion
import Foundation

@MainActor
final class AppModel: ObservableObject {
    @Published private(set) var status = "Ready"
    @Published private(set) var notificationPermissionGranted: Bool?

    @Published private(set) var motionCaptureActive = false
    @Published private(set) var motionSampleCount = 0
    @Published private(set) var latestAccelerationMagnitude: Double?
    @Published private(set) var latestSampleAt: Date?
    @Published private(set) var largestSampleGap: TimeInterval = 0
    @Published private(set) var lifecycleEvents: [String] = []

    private let notificationService = NotificationService()
    private let haptics = Haptics()
    private let motionManager = CMMotionManager()
    private let motionQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "WatchMeDance.motion"
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    private var engine = MovementEngine()

    var motionSummary: String {
        guard motionSampleCount > 0 else {
            return motionCaptureActive ? "Waiting for motion samples…" : "No motion samples yet"
        }

        let magnitude = latestAccelerationMagnitude.map { String(format: "%.3f g", $0) } ?? "unknown"
        let gap = String(format: "%.1f s", largestSampleGap)
        return "Samples: \(motionSampleCount) · latest acceleration: \(magnitude) · largest gap: \(gap)"
    }

    func playTestHaptic() {
        haptics.playTestHaptic()
        status = "Played test haptic"
    }

    func requestNotificationPermission() {
        status = "Requesting notification permission…"

        Task {
            do {
                let granted = try await notificationService.requestAuthorization()
                notificationPermissionGranted = granted
                status = granted ? "Notifications allowed" : "Notifications not allowed"
            } catch {
                status = "Notification permission failed: \(error.localizedDescription)"
            }
        }
    }

    func scheduleTestPrompt(timeSensitive: Bool) {
        status = timeSensitive
            ? "Scheduling time-sensitive prompt…"
            : "Scheduling normal prompt…"

        Task {
            do {
                try await notificationService.scheduleTestPrompt(
                    after: 10,
                    timeSensitive: timeSensitive
                )
                status = "Prompt scheduled for about 10 seconds from now"
            } catch {
                status = "Could not schedule prompt: \(error.localizedDescription)"
            }
        }
    }

    func recordManualCompletion() {
        let effects = engine.handle(.manualCompletion(at: Date()))
        status = effects.contains(.movementSnackCompleted)
            ? "Movement snack recorded"
            : "No completion recorded"
    }

    func startMotionCapture() {
        guard !motionCaptureActive else { return }
        guard motionManager.isDeviceMotionAvailable else {
            status = "Device motion is unavailable"
            return
        }

        motionSampleCount = 0
        latestAccelerationMagnitude = nil
        latestSampleAt = nil
        largestSampleGap = 0
        lifecycleEvents = []
        motionCaptureActive = true
        status = "Capturing raw motion"
        recordLifecycle("capture started")

        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self] motion, error in
            Task { @MainActor [weak self] in
                guard let self else { return }

                if let error {
                    self.status = "Motion capture error: \(error.localizedDescription)"
                    return
                }

                guard let motion else { return }
                let acceleration = motion.userAcceleration
                let magnitude = sqrt(
                    acceleration.x * acceleration.x
                    + acceleration.y * acceleration.y
                    + acceleration.z * acceleration.z
                )
                self.recordMotionSample(at: Date(), accelerationMagnitude: magnitude)
            }
        }
    }

    func stopMotionCapture() {
        guard motionCaptureActive else { return }
        motionManager.stopDeviceMotionUpdates()
        motionCaptureActive = false
        recordLifecycle("capture stopped")
        status = "Motion capture stopped"
    }

    func recordLifecycle(_ event: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        lifecycleEvents.append("\(formatter.string(from: Date())) \(event)")
        if lifecycleEvents.count > 12 {
            lifecycleEvents.removeFirst(lifecycleEvents.count - 12)
        }
    }

    private func recordMotionSample(at date: Date, accelerationMagnitude: Double) {
        if let previous = latestSampleAt {
            largestSampleGap = max(largestSampleGap, date.timeIntervalSince(previous))
        }

        latestSampleAt = date
        latestAccelerationMagnitude = accelerationMagnitude
        motionSampleCount += 1
    }
}
