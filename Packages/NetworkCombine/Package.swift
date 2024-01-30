// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkCombine",
    platforms: [.iOS(.v15), .tvOS(.v15)],
    products: [
        .library(
            name: "NetworkCombine",
            targets: ["NetworkCombine"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NetworkCombine",
            dependencies: []),
    ]
)
