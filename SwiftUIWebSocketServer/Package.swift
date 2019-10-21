// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIWebSocketServer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.8.1")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.9.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-WebSocket.git", from: "2.1.2")
    ],
    targets: [
        .target(
            name: "SwiftUIWebSocketServer",
            dependencies: ["Kitura", "Kitura-WebSocket", "HeliumLogger"]),
        .testTarget(
            name: "SwiftUIWebSocketServerTests",
            dependencies: ["SwiftUIWebSocketServer"]),
    ]
)

