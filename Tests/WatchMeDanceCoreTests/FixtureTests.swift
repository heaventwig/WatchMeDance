import Foundation
import XCTest
@testable import WatchMeDanceCore

final class FixtureTests: XCTestCase {
    func testBasicMovementCycleFixture() throws {
        let scenario = try loadScenario(named: "basic-movement-cycle.json")
        var engine = MovementEngine(
            policy: MovementPolicy(
                inactivityInterval: scenario.policy.inactivitySeconds,
                movementGoalDuration: scenario.policy.movementGoalSeconds
            )
        )
        let origin = Date(timeIntervalSince1970: 10_000)
        var observedEffects: [MovementEffect] = []

        for event in scenario.events {
            let date = origin.addingTimeInterval(event.at)
            switch event.type {
            case "inactivityBegan":
                observedEffects += engine.handle(.inactivityBegan(at: date))
            case "timeAdvanced":
                observedEffects += engine.handle(.timeAdvanced(to: date))
            case "movementBegan":
                observedEffects += engine.handle(.movementBegan(at: date))
            case "movementEnded":
                observedEffects += engine.handle(.movementEnded(at: date))
            case "manualCompletion":
                observedEffects += engine.handle(.manualCompletion(at: date))
            default:
                XCTFail("Unknown fixture event type: \(event.type)")
            }
        }

        XCTAssertEqual(observedEffects.map(\.rawValue), scenario.expectedEffects)
        XCTAssertEqual(engine.phase.rawValue, scenario.expectedFinalPhase)
    }

    private func loadScenario(named name: String) throws -> Scenario {
        let repositoryRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let url = repositoryRoot
            .appendingPathComponent("spec")
            .appendingPathComponent("fixtures")
            .appendingPathComponent(name)
        return try JSONDecoder().decode(Scenario.self, from: Data(contentsOf: url))
    }
}

private struct Scenario: Decodable {
    let name: String
    let policy: Policy
    let events: [Event]
    let expectedEffects: [String]
    let expectedFinalPhase: String

    struct Policy: Decodable {
        let inactivitySeconds: TimeInterval
        let movementGoalSeconds: TimeInterval
    }

    struct Event: Decodable {
        let type: String
        let at: TimeInterval
    }
}
