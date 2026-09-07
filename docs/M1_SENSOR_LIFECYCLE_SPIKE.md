# M1 sensor and lifecycle feasibility spike

This experiment asks what raw movement evidence a physical Apple Watch supplies during ordinary app lifecycle transitions before WatchMeDance chooses a background-runtime strategy or encodes an inactivity classifier.

This is instrumentation, not movement detection. Do not interpret missing samples as inactivity.

## Experiment 1: wrist-down gap

1. Install and open the M1 development build on the physical watch.
2. Tap **Start motion capture**.
3. Keep the app visible for about 60 seconds. Move the wrist naturally at least a few times.
4. Note the approximate sample count and largest sample gap.
5. Lower the wrist and leave it alone for about 60 seconds. Do not deliberately keep the app awake.
6. Raise the wrist and reopen WatchMeDance if needed.
7. Wait about 10 seconds.
8. Tap **Stop motion capture**.
9. Record:
   - final sample count;
   - largest sample gap;
   - lifecycle events shown;
   - whether samples resumed after reopening;
   - anything surprising.

Expected result is intentionally unspecified. A long gap, suspension, unavailable motion, continued delivery, or another outcome is useful feasibility evidence.

## What this spike records

- device-motion callbacks requested at 10 Hz while the process is allowed to run;
- user-acceleration magnitude for the latest callback;
- callback count;
- largest observed wall-clock interval between callbacks;
- selected SwiftUI scene lifecycle transitions.

The displayed values are development diagnostics only. They are not persisted, transmitted, or interpreted as health or activity data.

## What this spike does not establish

This experiment does not establish:

- that Core Motion callbacks continue when watchOS suspends the app;
- that a particular runtime mechanism is appropriate for passive all-day monitoring;
- that acceleration magnitude is a sufficient movement classifier;
- acceptable battery cost;
- heart-rate or HealthKit availability;
- a final sampling cadence;
- a definition of inactivity or qualifying movement.

Choose or reject background-runtime mechanisms only after observing the ordinary lifecycle behavior and checking that the mechanism semantically fits the product rather than using it merely to keep the process alive.
