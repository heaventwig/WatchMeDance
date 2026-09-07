import Foundation

@MainActor
final class AppModel: ObservableObject {
    @Published private(set) var status = "Ready"
    @Published private(set) var notificationPermissionGranted: Bool?

    private let notificationService = NotificationService()
    private let haptics = Haptics()
    private var engine = MovementEngine()

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
}
