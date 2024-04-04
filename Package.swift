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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.1.1/KYCAIDSDK.xcframework.zip",
            checksum: "8a71e2746493c42dd6b05f704ef64eab5b240d64b1472075e36a21d5b4b3b301"
        )
    ]
)
