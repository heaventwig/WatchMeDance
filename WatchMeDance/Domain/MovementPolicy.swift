import Foundation

public struct MovementPolicy: Equatable, Sendable {
    public var inactivityInterval: TimeInterval
    public var movementGoalDuration: TimeInterval

    public init(
        inactivityInterval: TimeInterval,
        movementGoalDuration: TimeInterval
    ) {
        precondition(inactivityInterval > 0)
        precondition(movementGoalDuration > 0)
        self.inactivityInterval = inactivityInterval
        self.movementGoalDuration = movementGoalDuration
    }

    /// Current research-informed product baseline. These values are a product
    /// hypothesis, not a claim that the engine can yet detect either interval
    /// reliably from watch sensors in the background.
    public static let researchBaseline = MovementPolicy(
        inactivityInterval: 25 * 60,
        movementGoalDuration: 5 * 60
    )
}
