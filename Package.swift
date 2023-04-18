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
            name: "Layouts",
            targets: ["Layouts"]),
    ],
    
    dependencies: [

    ],
    
    targets: [
        .target(
            name: "Layouts",
            dependencies: []),
    ]
)
