// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "KYCAID",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "KYCAID",
            targets: ["KYCAIDSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.8/KYCAIDSDK.xcframework.zip",
            checksum: "154e940e1855cae59b04059b1dcfe5ebd5b396e467c01d96b39717b4a133e55b"
        )
    ]
)
