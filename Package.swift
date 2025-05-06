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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.4/KYCAIDSDK.xcframework.zip",
            checksum: "cb34224d715eaaddaa0fef438402c51ae10d02c2aeb3b7ce53f831825fd7bb89"
        )
    ]
)
