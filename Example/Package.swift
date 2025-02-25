// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "swift-power-assert-example",
  platforms: [
    .iOS(.v16),
    .macOS(.v13)
  ],
  dependencies: [
    .package(
      path: ".."
    ),
  ],
  targets: [
    .testTarget(
      name: "ExampleTests",
      dependencies: [
        .product(name: "PowerAssert", package: "swift-power-assert")
      ]
    ),
  ]
)
