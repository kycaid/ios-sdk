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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.7/KYCAIDSDK.xcframework.zip",
            checksum: "4179d97fd3dce5e7bc8a676207cb3d18403be31a1601f26730a0a8b33ec29ff3"
        )
    ]
)
