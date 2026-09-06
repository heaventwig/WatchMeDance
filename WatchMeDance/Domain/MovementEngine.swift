import Foundation

public enum MovementPhase: String, Codable, Equatable, Sendable {
    case monitoring
    case promptDue
    case moving
}

public enum MovementEffect: String, Codable, Equatable, Sendable {
    case promptDue
    case movementSnackCompleted
}

public enum MovementEvent: Equatable, Sendable {
    case inactivityBegan(at: Date)
    case timeAdvanced(to: Date)
    case movementBegan(at: Date)
    case movementEnded(at: Date)
    case manualCompletion(at: Date)
}

public struct MovementEngine: Equatable, Sendable {
    public let policy: MovementPolicy

    public private(set) var phase: MovementPhase = .monitoring
    public private(set) var inactivityBeganAt: Date?
    public private(set) var movementBeganAt: Date?
    public private(set) var promptIssued = false

    public init(policy: MovementPolicy = .researchBaseline) {
        self.policy = policy
    }

    @discardableResult
    public mutating func handle(_ event: MovementEvent) -> [MovementEffect] {
        switch event {
        case let .inactivityBegan(at):
            inactivityBeganAt = at
            movementBeganAt = nil
            promptIssued = false
            phase = .monitoring
            return []

        case let .timeAdvanced(to):
            if let movementBeganAt,
               to.timeIntervalSince(movementBeganAt) >= policy.movementGoalDuration {
                return completeMovementSnack()
            }

            if let inactivityBeganAt,
               !promptIssued,
               to.timeIntervalSince(inactivityBeganAt) >= policy.inactivityInterval {
                promptIssued = true
                phase = .promptDue
                return [.promptDue]
            }

            return []

        case let .movementBegan(at):
            movementBeganAt = at
            phase = .moving
            return []

        case .movementEnded:
            movementBeganAt = nil
            phase = promptIssued ? .promptDue : .monitoring
            return []

        case .manualCompletion:
            return completeMovementSnack()
        }
    }

    private mutating func completeMovementSnack() -> [MovementEffect] {
        inactivityBeganAt = nil
        movementBeganAt = nil
        promptIssued = false
        phase = .monitoring
        return [.movementSnackCompleted]
    }
}
