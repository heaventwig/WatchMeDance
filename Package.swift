// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WatchMeDanceCore",
    platforms: [
        .watchOS(.v10)
    ],
    products: [
        .library(name: "WatchMeDanceCore", targets: ["WatchMeDanceCore"])
    ],
    targets: [
        .target(
            name: "WatchMeDanceCore",
            path: "WatchMeDance/Domain"
        ),
        .testTarget(
            name: "WatchMeDanceCoreTests",
            dependencies: ["WatchMeDanceCore"],
            path: "Tests/WatchMeDanceCoreTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
