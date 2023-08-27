// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_swiftgen",
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGen", .exact("6.6.2"))
    ]
)
