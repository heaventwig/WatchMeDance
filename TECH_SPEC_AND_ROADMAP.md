# WatchMeDance technical specification and roadmap

WatchMeDance is an open-source smartwatch app intended to support regular, accessible "movement snacks" during otherwise low-movement periods.

The project starts with watchOS and is designed so that later Wear OS and PineTime implementations can share behavioral specifications without requiring a shared codebase.

## Current MVP hypothesis

A watch app that notices prolonged low movement and gives a timely, respectful prompt can help a user complete a short movement snack without becoming annoying, inaccessible, or unreasonably expensive in battery use.

This is a product hypothesis to test. It is separate from the scientific question of the health effects of any particular movement protocol.

## Technical specifications

### Platform compatibility

- Initial implementation: watchOS 10 or later.
- Future implementations may target Wear OS, PineTime, or other watch environments.
- Cross-platform consistency should come primarily from shared behavioral specifications and fixtures, not from forcing platforms into one codebase.

### Movement evidence

- Treat movement as capability-neutral. Do not require standing, walking, or a particular body position.
- Platform adapters may combine motion, activity, heart-rate, workout, or other available signals when evidence supports doing so.
- Missing or stale sensor data is an unknown state, not evidence that the user is inactive.
- The sensor definition of "qualifying movement" remains an active feasibility and accessibility question.

### Timing baseline

The current working baseline is:

- after 25 minutes of sufficiently low movement, a movement prompt becomes due;
- after 5 minutes of qualifying continuous movement, the current movement snack is complete and the inactivity cycle resets.

These numbers are the initial product baseline and should remain easy to change as evidence develops.

### Movement prompts

- Begin with haptic interaction where the platform permits.
- Support progressively more noticeable prompts only when useful and respectful.
- Support pause and snooze behavior.
- Use sound only when enabled by the user and appropriate to platform/context.
- Treat Focus/DND interruption as a platform capability subject to user settings and OS policy, not as something the app can guarantee.
- Where supported, test ordinary and Time Sensitive notifications separately.

### User preferences and accessibility

- Let users control prompt timing and interruption behavior where practical.
- Avoid assumptions that more vigorous movement, standing, or walking is always the appropriate response.
- Future personalization may include user-calibrated movement evidence and prompt-only operation where automatic sensing is unsuitable.
- Design for VoiceOver, reduced dexterity, fatigue, limited attention, and small-screen use from the start.

### Activity logging

- Logging is not required for the first development loop.
- When added, record only information that supports useful user feedback or project learning.
- Prefer local-first storage and collect no remote health data by default.

## Development roadmap

### M0 - Repository-to-watch development loop

Goal: prove that we can reliably move from source code to a real watch and exercise the basic interaction mechanisms.

Deliverables:

- watch-only SwiftUI app;
- direct test haptic;
- local notification permission and scheduling;
- ordinary and Time Sensitive test prompts;
- manual movement-completion action;
- platform-neutral state-machine core;
- automated core tests and first shared behavioral fixture;
- repeatable build/test instructions.

### M1 - Sensor and background feasibility

Goal: learn what movement evidence and runtime behavior watchOS actually supplies reliably enough for the product.

Test:

- candidate movement/activity/heart-rate signals;
- sample cadence and gaps;
- background delivery/runtime behavior;
- battery cost;
- prompt delivery while the app is not foregrounded;
- behavior under selected Focus/DND conditions.

Instrument the build so failures and unavailable evidence are visible rather than silently interpreted as inactivity.

### M2 - First usable watchOS alpha

Goal: complete the smallest useful loop:

`movement evidence -> low-movement interval -> prompt -> qualifying movement -> completion/reset`

Include pause/snooze, explicit monitoring-unavailable state, and a manual/prompt-only fallback where useful.

### M3 - Field learning and refinement

Use real-watch evidence to improve:

- prompt timing and escalation;
- false-positive and false-negative behavior;
- accessibility and energy cost for users;
- battery use and reliability;
- movement calibration and personalization.

Avoid adding dashboards or elaborate history until they answer a demonstrated user need.

### M4 - Cross-platform implementation

After the behavioral core is stable enough to be useful, implement Wear OS and evaluate PineTime feasibility. Require platform implementations to satisfy the same applicable shared behavioral fixtures while allowing platform-native architecture and UX.

### Later - Distribution and stewardship

If broader distribution becomes useful:

- evaluate TestFlight and App Store distribution;
- define privacy disclosures and data stewardship;
- decide whether monetization is useful;
- if proceeds exist, establish a transparent contributor/nonprofit allocation model;
- consider durable project-governance and maintenance arrangements.

## Collaboration

- GitHub is the canonical source repository.
- Development changes should be small, reviewable, and tested proportionately to their claims.
- Keep implementation details platform-native while preserving shared behavior, accessibility intent, and evidence.
- See `DESIGN_AND_ARCHITECTURE.md`, `CONTRIBUTING.md`, and `CONDUCT.md`.
