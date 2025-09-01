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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.0/KYCAIDSDK.xcframework.zip",
            checksum: "54b6a16b51b26d05ccc763b479cfdd64307e999af28a5aea625a28198e7eb9e1"
        )
    ]
)
