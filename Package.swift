// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShortcutBox",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "Shortcut", targets: ["Shortcut"]),
        .executable(name: "ShortcutBox", targets: ["ShortcutBox"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "Shortcut"),
        .executableTarget(name: "ShortcutBox", dependencies: [
            .byName(name: "Shortcut"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
    ]
)
