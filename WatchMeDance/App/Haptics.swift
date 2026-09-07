import WatchKit

struct Haptics {
    func playTestHaptic() {
        WKInterfaceDevice.current().play(.notification)
    }
}
