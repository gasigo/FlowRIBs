// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "FlowRIBs",
	platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "FlowRIBs",
            targets: ["FlowRIBs"]
		),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FlowRIBs",
            dependencies: []
		),
        .testTarget(
            name: "FlowRIBsTests",
            dependencies: ["FlowRIBs"]
		)
    ]
)
