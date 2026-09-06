# WatchMeDance domain model

This document defines the first executable cross-platform behavior contract. It is intentionally smaller than the full product specification.

## Purpose

Keep product behavior separate from watchOS, Wear OS, PineTime, sensor APIs, notification APIs, persistence, and UI frameworks. Each platform can use different code while preserving equivalent user-facing behavior where its capabilities allow.

## Current policy baseline

The current working baseline is:

- prompt after 25 minutes of sufficiently low movement;
- recognize a movement snack after 5 minutes of qualifying continuous movement.

These are product hypotheses to test. They are not claims that the first watchOS build can reliably infer either state from background sensors.

## State machine

The pure domain engine currently recognizes three phases:

- `monitoring`: no prompt is currently due;
- `promptDue`: the inactivity interval has crossed the configured boundary;
- `moving`: qualifying movement has begun but has not yet reached the configured duration.

It emits two effects:

- `promptDue`;
- `movementSnackCompleted`.

Platform code decides how to obtain movement evidence and how to turn `promptDue` into an actual user interaction. Missing sensor data must not be treated as evidence that the user is inactive.

## Shared fixtures

Machine-readable scenarios in `spec/fixtures/` are intended to become a behavioral contract across implementations. The first fixture is deliberately simple. Swift tests execute it now; later Kotlin and PineTime implementations should be able to execute the same scenario without sharing source code.

## Not yet specified

The following remain evidence-dependent and should not be silently encoded as settled behavior:

- the sensor or sensor combination that constitutes sufficient movement evidence;
- acceptable evidence gaps and sampling cadence;
- background-runtime guarantees;
- prompt escalation and Focus/DND policy;
- persistence across termination or reboot;
- personalization and accessibility profiles;
- whether movement duration must always be continuous.
