# First watchOS development loop

This build is development scaffolding, not a health product and not yet the movement-detection MVP. Its purpose is to prove the shortest path from repository code to a real Apple Watch and to test basic prompt mechanisms.

## Verified development baseline

As of 2026-09-07:

- Xcode 26.6 (build 17F113) on macOS 26.6.2;
- watchOS 26.5 simulator runtime installed;
- `swift test` passes locally;
- unsigned watchOS simulator build succeeds locally with Xcode 26.6;
- GitHub Actions also passes core tests and the unsigned watchOS simulator build.

## Build

1. Install and open Xcode 26.6 or another Xcode release that supports watchOS 10.
2. Open `WatchMeDance.xcodeproj`.
3. Select the `WatchMeDance` target.
4. In **Signing & Capabilities**, choose your Apple Account's Personal Team (or another authorized development team).
5. Select your paired Apple Watch, or a watchOS simulator, as the run destination.
6. Press **Run**.
7. Follow any Xcode/device prompts for trust, signing, or Developer Mode.

If Xcode reports that `com.heaventwig.WatchMeDance` cannot be registered to your team, stop and report that exact message; do not make unrelated signing changes yet.

## Pairing a physical Apple Watch

A physical Apple Watch is paired to Xcode through its companion iPhone; the watch itself is not connected to the Mac by USB.

- Pair the companion iPhone with the Mac first in Xcode's Device Hub.
- For older watches, keep the Mac, iPhone, and watch on a local network that permits Bonjour discovery.
- If Xcode's Device Hub asks for a USB-connected device, that refers to the companion iPhone, not the watch.
- After the iPhone is paired with Xcode, the associated Apple Watch can become an eligible run destination.
- Enable Developer Mode on the iPhone and Apple Watch if Xcode requests it.

### Observed setup evidence

On 2026-09-07, before the companion iPhone was paired with Xcode, the run-destination menu showed no eligible physical devices and automatic signing could not create a provisioning profile because the Personal Team had no registered device. Treat that as a device-pairing prerequisite, not yet as evidence of a signing or application-code defect.

## First physical-watch checks

Run these in order and record pass/fail plus anything surprising:

1. **Launch:** WatchMeDance opens and shows `Ready`.
2. **Haptic:** tap **Play test haptic**. The watch should produce a notification-style haptic.
3. **Permission:** tap **Allow prompts** and allow notifications when asked.
4. **Normal local prompt:** tap **Normal prompt in 10s**, then leave the app (for example, press the Digital Crown). Observe whether a notification arrives.
5. **Time-sensitive local prompt:** repeat with **Time-sensitive in 10s** under ordinary conditions. Focus/DND testing comes after basic delivery works.
6. **Manual completion:** reopen the app and tap **I moved**. The status should become `Movement snack recorded`.

Do not spend time debugging a failed step before capturing the exact failure. The failure is useful feasibility evidence.

## Core tests

From the repository root:

```sh
swift test
```

The core tests use no watchOS framework and exercise the platform-neutral state machine plus the shared behavioral fixture.
