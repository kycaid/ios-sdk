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
            checksum: "a15dc2f9ca67bed0bf81af4c00d5390a02373487429f7ed0d57c1faebb82f4bc"
        )
    ]
)
