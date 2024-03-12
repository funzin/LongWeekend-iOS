// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_licesnse_plist",
    dependencies: [
        .package(url: "https://github.com/mono0926/LicensePlist", .exact("3.25.1"))
    ]
)
