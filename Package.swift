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
            url: "https://github.com/kycaid/ios-sdk/releases/download/0.9.0/KYCAIDSDK.xcframework.zip",
            checksum: "4362a78615ac161429115d06e30159f4267207d6255c97fcfc7f3cced949dacf"
        )
    ]
)
