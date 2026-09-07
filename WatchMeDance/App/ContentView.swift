import SwiftUI

struct ContentView: View {
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
            }
            .padding(.horizontal, 4)
        }
    }
}
