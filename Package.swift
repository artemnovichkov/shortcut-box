// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShortcutBox",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "ShortcutBox", targets: ["ShortcutBox"]),
    ],
    targets: [
        .target(name: "ShortcutBox", dependencies: []),
    ]
)
