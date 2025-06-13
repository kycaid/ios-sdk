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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.6.1/KYCAIDSDK.xcframework.zip",
            checksum: "c087e237ee3d5ed4d6d8faa7cd00774fa0feccf5db85f359655d26c7849d80b1"
        )
    ]
)
