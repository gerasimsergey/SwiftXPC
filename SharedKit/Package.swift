// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SharedKit",
    platforms: [.macOS(.v10_15)],
    products: [.library(name: "SharedKit", targets: ["SharedKit"])],
    dependencies: [],
    targets: [.target(name: "SharedKit", dependencies: [])]
)
