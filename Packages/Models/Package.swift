// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Models",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(
      name: "Models",
      targets: ["Models"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Models",
      dependencies: []),
    .testTarget(
      name: "ModelsTests",
      dependencies: ["Models"]),
  ]
)
