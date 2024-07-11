// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_xcodegen",
    dependencies: [
        .package(url: "https://github.com/yonaskolb/xcodegen", .exact("2.42.0"))
    ]
)
