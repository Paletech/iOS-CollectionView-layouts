// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Collection-View-Layouts",
    platforms: [
        .iOS(.v16)
    ],
    products: [

        .library(
            name: "Infinite",
            targets: ["Infinite"]),
    ],
    dependencies: [

    ],
    targets: [
 
        .target(
            name: "Infinite",
            dependencies: [])
    ]
)
