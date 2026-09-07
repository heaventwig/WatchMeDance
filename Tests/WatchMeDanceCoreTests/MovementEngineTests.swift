import XCTest
@testable import WatchMeDanceCore

final class MovementEngineTests: XCTestCase {
    private let start = Date(timeIntervalSince1970: 1_000)

    func testPromptIsDueAtInactivityBoundary() {
        var engine = MovementEngine(
            policy: MovementPolicy(inactivityInterval: 1_500, movementGoalDuration: 300)
        )

        XCTAssertEqual(engine.handle(.inactivityBegan(at: start)), [])
        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: start.addingTimeInterval(1_499))),
            []
        )
        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: start.addingTimeInterval(1_500))),
            [.promptDue]
        )
        XCTAssertEqual(engine.phase, .promptDue)

        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: start.addingTimeInterval(1_501))),
            []
        )
    }

    func testFiveMinutesOfContinuousMovementCompletesSnack() {
        var engine = MovementEngine(
            policy: MovementPolicy(inactivityInterval: 1_500, movementGoalDuration: 300)
        )
        engine.handle(.inactivityBegan(at: start))
        engine.handle(.timeAdvanced(to: start.addingTimeInterval(1_500)))
        let movementStart = start.addingTimeInterval(1_510)

        XCTAssertEqual(engine.handle(.movementBegan(at: movementStart)), [])
        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: movementStart.addingTimeInterval(299))),
            []
        )
        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: movementStart.addingTimeInterval(300))),
            [.movementSnackCompleted]
        )
        XCTAssertEqual(engine.phase, .monitoring)
        XCTAssertNil(engine.inactivityBeganAt)
        XCTAssertNil(engine.movementBeganAt)
    }

    func testInterruptedMovementDoesNotAccumulateAcrossIntervals() {
        var engine = MovementEngine(
            policy: MovementPolicy(inactivityInterval: 1_500, movementGoalDuration: 300)
        )
        engine.handle(.inactivityBegan(at: start))
        engine.handle(.timeAdvanced(to: start.addingTimeInterval(1_500)))

        let firstMovement = start.addingTimeInterval(1_510)
        engine.handle(.movementBegan(at: firstMovement))
        engine.handle(.timeAdvanced(to: firstMovement.addingTimeInterval(200)))
        engine.handle(.movementEnded(at: firstMovement.addingTimeInterval(200)))

        let secondMovement = firstMovement.addingTimeInterval(210)
        engine.handle(.movementBegan(at: secondMovement))

        XCTAssertEqual(
            engine.handle(.timeAdvanced(to: secondMovement.addingTimeInterval(100))),
            []
        )
        XCTAssertEqual(engine.phase, .moving)
    }

    func testManualCompletionResetsCycle() {
        var engine = MovementEngine()
        engine.handle(.inactivityBegan(at: start))

        XCTAssertEqual(
            engine.handle(.manualCompletion(at: start.addingTimeInterval(60))),
            [.movementSnackCompleted]
        )
        XCTAssertEqual(engine.phase, .monitoring)
        XCTAssertFalse(engine.promptIssued)
        XCTAssertNil(engine.inactivityBeganAt)
    }
}
