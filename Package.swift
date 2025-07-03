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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.7.0/KYCAIDSDK.xcframework.zip",
            checksum: "1884489df06dce55593fab9525c09ba7c530fa32970c3207dc39e6e02c9f6eb0"
        )
    ]
)
