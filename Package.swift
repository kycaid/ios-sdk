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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.8.0/KYCAIDSDK.xcframework.zip",
            checksum: "020982f0a4f74e3e3b5d6f4b2eaddcfcf32c573e7986bfb0b0cc2533b1308a1e"
        )
    ]
)
