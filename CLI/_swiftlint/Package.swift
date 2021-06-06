// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_swiftlint",
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", .exact("0.43.1"))
    ]
)
