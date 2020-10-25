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
            url: "https://github.com/kycaid/ios-sdk/releases/download/0.9.1/KYCAIDSDK.xcframework.zip",
            checksum: "3118eebc1cec8793f612f2fb20dcc088d428ed7119d01f927bebe4e504dc9370"
        )
    ]
)