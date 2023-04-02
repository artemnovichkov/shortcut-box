// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShortcutBox",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(name: "Shortcut", targets: ["Shortcut"]),
        .executable(name: "ShortcutBox", targets: ["ShortcutBox"]),
    ],
    targets: [
        .target(name: "Shortcut"),
        .executableTarget(name: "ShortcutBox", dependencies: [.byName(name: "Shortcut")]),
    ]
)
