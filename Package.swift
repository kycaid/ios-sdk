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
            checksum: "51ada46f3c31d7ba1636f2bf5053f041bbb22fecc01fa388d8b11ccb07102a1a"
        )
    ]
)
