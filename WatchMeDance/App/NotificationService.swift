import Foundation
import UserNotifications

struct NotificationService {
    func requestAuthorization() async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound]
        )
    }

    func scheduleTestPrompt(
        after seconds: TimeInterval = 10,
        timeSensitive: Bool
    ) async throws {
        let content = UNMutableNotificationContent()
        content.title = "Movement snack?"
        content.body = "If movement works for you right now, this is a small invitation to move."
        content.sound = .default

        if timeSensitive {
            content.interruptionLevel = .timeSensitive
        }

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: max(1, seconds),
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        try await UNUserNotificationCenter.current().add(request)
    }
}
