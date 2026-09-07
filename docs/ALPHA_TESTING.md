# First watchOS development loop

This build is development scaffolding, not a health product and not yet the movement-detection MVP. Its purpose is to prove the shortest path from repository code to a real Apple Watch and to test basic prompt mechanisms.

## Verified development baseline

As of 2026-09-07:

- Xcode 26.6 (build 17F113) on macOS 26.6.2;
- watchOS 26.5 simulator runtime installed;
- `swift test` passes locally;
- unsigned watchOS simulator build succeeds locally with Xcode 26.6;
- GitHub Actions passes core tests and the unsigned watchOS simulator build;
- a signed Debug build succeeds for a registered physical Apple Watch;
- direct CoreDevice installation succeeds on an Apple Watch Series 4 (Watch4,3);
- all six first physical-watch checks below passed.

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
- For older watches, keep the Mac, iPhone, and watch on a local network that permits Bonjour discovery and usable peer-to-peer unicast traffic.
- If Xcode's Device Hub asks for a USB-connected device, that refers to the companion iPhone, not the watch.
- After the iPhone is paired with Xcode, the associated Apple Watch can become an eligible run destination.
- Enable Developer Mode on the iPhone and Apple Watch if Xcode requests it.

### Observed setup evidence

On 2026-09-07, before the companion iPhone was paired with Xcode, the run-destination menu showed no eligible physical devices and automatic signing could not create a provisioning profile because the Personal Team had no registered device. This proved to be a device-registration/pairing prerequisite rather than an application-code defect.

The initial local Wi-Fi network allowed Bonjour discovery of the watch's `_remotepairing._tcp` services but did not provide usable unicast connectivity to the advertised watch endpoint: ARP resolution remained incomplete, IPv4 and IPv6 pings failed, and the advertised RemotePairing TCP ports timed out. Xcode consequently stalled during device preparation/shared-cache symbol work and `devicectl` timed out while preparing its CoreDevice control channel.

A temporary Wi-Fi network hosted by the development Mac removed that transport blocker. With the watch joined to that network, a signed build could be installed directly with `devicectl` and launched successfully. Treat this as environment-specific feasibility evidence, not as a requirement that WatchMeDance users or contributors use Mac Internet Sharing.

When Xcode's normal Run path is blocked by device preparation but signing succeeds, a useful diagnostic fallback is:

```sh
xcodebuild \
  -project WatchMeDance.xcodeproj \
  -scheme WatchMeDance \
  -configuration Debug \
  -destination 'generic/platform=watchOS' \
  -derivedDataPath "$PWD/.direct-device-build" \
  -allowProvisioningUpdates \
  build

xcrun devicectl device install app \
  --device '<CoreDevice ID>' \
  --timeout 240 \
  "$PWD/.direct-device-build/Build/Products/Debug-watchos/WatchMeDance.app"
```

Use the CoreDevice identifier reported by `xcrun devicectl list devices` for the install command. Do not commit personal device or team identifiers to the repository.

## First physical-watch checks

Run these in order and record pass/fail plus anything surprising:

1. **Launch:** WatchMeDance opens and shows `Ready`.
2. **Haptic:** tap **Play test haptic**. The watch should produce a notification-style haptic.
3. **Permission:** tap **Allow prompts** and allow notifications when asked.
4. **Normal local prompt:** tap **Normal prompt in 10s**, then leave the app (for example, press the Digital Crown). Observe whether a notification arrives.
5. **Time-sensitive local prompt:** repeat with **Time-sensitive in 10s** under ordinary conditions. Focus/DND testing comes after basic delivery works.
6. **Manual completion:** reopen the app and tap **I moved**. The status should become `Movement snack recorded`.

### Physical result: 2026-09-07

All six checks passed on the first physical-watch development loop after installation succeeded.

The main interaction surprise was that leaving the app, as instructed, mattered for observing the local-notification checks. Both the ordinary and Time Sensitive notifications were observed in that backgrounded test path. Foreground-notification presentation was not part of this M0 acceptance check and remains unspecified.

Focus/DND behavior, sensor acquisition, background sensing/runtime, battery cost, and movement classification remain outside M0.

## Core tests

From the repository root:

```sh
swift test
```

The core tests use no watchOS framework and exercise the platform-neutral state machine plus the shared behavioral fixture.
