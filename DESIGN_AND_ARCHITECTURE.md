# WatchMeDance design and architectural guidelines

## Purpose

This document is a living reference for contributors. It describes the practices we currently intend to use while building a user-centered, accessible, cross-platform smartwatch app.

The guidelines are meant to help, not to reward ceremony. When a guideline adds complexity without improving users, correctness, learning, or contributor experience, raise that concern.

## Core principles

### Accessibility first

Do not make standing, walking, a particular range of motion, or a particular body response the definition of successful movement. Design for users with different bodies, mobility, fatigue, attention, sensory, and energy constraints.

### Clarity

Prefer code and interfaces whose purpose is easy to discover. Use names that describe intent. Comment the reason for surprising decisions rather than narrating obvious code.

### Small, simple parts in useful interaction

Prefer small components with narrow responsibilities and explicit interfaces. Complex behavior should emerge from understandable parts working together rather than from large objects that know everything.

This is a design preference, not a demand for artificially tiny files or abstractions.

### Evidence before premature abstraction

Build the smallest architecture that protects currently important boundaries. Let physical-device evidence teach us what deserves further abstraction.

### Platform-native implementation, shared behavior

watchOS, Wear OS, and PineTime may use substantially different code and UI architecture. Cross-platform consistency lives primarily in shared domain terminology, behavioral specifications, acceptance fixtures, and user-facing intent.

## Architecture

### Platform-neutral domain core

Behavior that does not require a watch API belongs in a deterministic domain layer. The core should not directly depend on:

- SwiftUI, Compose, or another UI toolkit;
- HealthKit or platform sensor APIs;
- notification APIs;
- persistence frameworks;
- wall-clock access;
- networking.

Pass facts and events into the core and let it return state/effects. This makes behavior fast to test and portable to other implementations.

The first executable contract is documented in `spec/DOMAIN_MODEL.md`.

### Platform adapters

Platform-specific code translates native capabilities into domain events and translates domain effects into native behavior.

Examples include:

- movement evidence source;
- clock/scheduler;
- notifications and haptics;
- persistence;
- application lifecycle;
- diagnostics.

An adapter must report unavailable or stale evidence rather than inventing certainty.

### UI

For watchOS, use SwiftUI unless a concrete need justifies otherwise. Keep views focused on presentation and user interaction; keep product rules in the domain/application layers.

Later platforms should use their normal native UI tools rather than imitate SwiftUI structurally.

## Testing

### Test-driven development

For deterministic product behavior, prefer writing or tightening a test before changing the behavior it specifies. Exploratory platform spikes may begin with instrumentation instead when the purpose is to discover what the platform actually does.

### Shared behavioral fixtures

Machine-readable cases in `spec/fixtures/` are the intended cross-platform acceptance seam. Each implementation may use native test frameworks while consuming the same applicable scenarios.

### Native tests

- Swift/watchOS: Swift Testing or XCTest as appropriate; current core uses XCTest through Swift Package Manager.
- Kotlin/Wear OS: native Kotlin/JVM and Compose/Wear test tools when that implementation begins.
- PineTime: use the firmware project's native C/C++ test approach, with host-based tests where practical.

### Integration and physical-device tests

Simulators are useful but cannot establish battery cost, sensor cadence, or all background behavior. Treat physical-watch observations as distinct evidence and record failures before trying to explain them away.

## Code style and linting

- Swift follows the Swift API Design Guidelines.
- Kotlin should follow the official Kotlin coding conventions when Kotlin code exists.
- JavaScript should follow the selected project JavaScript convention if JavaScript is introduced.
- Prefer automated formatting/linting over review comments about whitespace or trivial style.
- Do not claim a linter is required until its configuration and reproducible command exist in the repository.

SwiftLint, ktlint, and ESLint are reasonable candidates, but adoption is an implementation decision rather than current conformance evidence.

## Documentation

- Keep setup instructions executable and current.
- Explain architecture at the boundary where a newcomer needs it.
- Keep normative product behavior separate from platform observations and hypotheses.
- Prefer Markdown stored with the code so changes can be reviewed together.

## Privacy and security

- Prefer local processing and local storage.
- Collect no remote health or movement data by default.
- Add network services only for a demonstrated user or project need.
- Minimize permissions and explain why each permission is requested.
- Never commit credentials, signing secrets, private health data, or production tokens.

## Performance and battery

Smartwatches are constrained devices. Avoid continuous work that the product does not need. Measure battery and runtime behavior on physical hardware before treating an approach as acceptable.

## Internationalization

Keep user-facing strings easy to localize and avoid encoding English grammar into domain behavior. Full localization infrastructure can follow once there is enough interface to justify it.

## Continuous integration

CI should run checks contributors can reproduce locally where practical. A passing check is evidence about that check's scope, not proof that the app works on a physical watch.

## Contributor experience

Design the codebase so a newcomer can find a small useful piece to understand, test, or improve without first learning the entire system. See `CONTRIBUTING.md` for contribution mechanics and `CONDUCT.md` for interaction expectations.

## Maintaining this document

Change these guidelines when evidence or platform evolution warrants it. Preserve the reason for material architectural changes in the PR or an appropriate decision record so later contributors can challenge the decision rather than merely inherit it.
