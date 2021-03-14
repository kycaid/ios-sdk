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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.5/KYCAIDSDK.xcframework.zip",
            checksum: "3098926fc7d2067e3edcf6d2ba3a7b5077d8b1e9e5dc0b1429debd7ce82d07ea"
        )
    ]
)
