// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_swiftformat",
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", .exact("0.54.6"))
    ]
)

