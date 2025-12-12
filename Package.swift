// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pointer-kit",
    products: [
        .library(
            name: "PointerKit",
            targets: ["PointerKit"],
        ),
    ],
    targets: [
        .target(
            name: "PointerKit",
        ),
        .testTarget(
            name: "PointerKitTests",
            dependencies: ["PointerKit"],
        ),
    ]
)
