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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.3/KYCAIDSDK.xcframework.zip",
            checksum: "af8f75c784f8dcb5357598e0d07e28655b5f2b95706556bdea8a9ebf1d168ac5"
        )
    ]
)
