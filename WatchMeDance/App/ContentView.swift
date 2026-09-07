import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("WatchMeDance")
                    .font(.headline)

                Text("Development build")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(model.status)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Status: \(model.status)")

                Button("Play test haptic") {
                    model.playTestHaptic()
                }

                Button("Allow prompts") {
                    model.requestNotificationPermission()
                }

                Button("Normal prompt in 10s") {
                    model.scheduleTestPrompt(timeSensitive: false)
                }

                Button("Time-sensitive in 10s") {
                    model.scheduleTestPrompt(timeSensitive: true)
                }

                Button("I moved") {
                    model.recordManualCompletion()
                }

                Divider()

                Text("M1 motion spike")
                    .font(.caption)
                    .bold()

                Text(model.motionSummary)
                    .font(.caption2)
                    .multilineTextAlignment(.center)

                if model.motionCaptureActive {
                    Button("Stop motion capture") {
                        model.stopMotionCapture()
                    }
                } else {
                    Button("Start motion capture") {
                        model.startMotionCapture()
                    }
                }

                if !model.lifecycleEvents.isEmpty {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Lifecycle")
                            .font(.caption2)
                            .bold()

                        ForEach(Array(model.lifecycleEvents.enumerated()), id: \.offset) { _, event in
                            Text(event)
                                .font(.system(size: 9, design: .monospaced))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 4)
        }
        .onAppear {
            model.recordLifecycle("view appeared")
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                model.recordLifecycle("scene active")
            case .inactive:
                model.recordLifecycle("scene inactive")
            case .background:
                model.recordLifecycle("scene background")
            @unknown default:
                model.recordLifecycle("scene unknown")
            }
        }
    }
}
