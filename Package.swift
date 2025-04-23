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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.0-rc01/KYCAIDSDK.xcframework.zip",
            checksum: "68bcb123601b95acc0913abb5dca6dc99f829d2881aa4b045d4e979fd2c9f36c"
        )
    ]
)
