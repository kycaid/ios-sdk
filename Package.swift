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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.1-beta/KYCAIDSDK.xcframework.zip",
            checksum: "7a4f3806e399fcd9faf7e49df3838cf97d26942d22d8b7255a264ab56e611f29"
        )
    ]
)
