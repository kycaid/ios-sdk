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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.0/KYCAIDSDK.xcframework.zip",
            checksum: "3f141522b7a257127a66958420461e428032fd52e0806ed764f22d095eda0e5d"
        )
    ]
)
