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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.1/KYCAIDSDK.xcframework.zip",
            checksum: "6229738f66fced136918be57b77939643a347aa19e068b0598d83ac49b89fec0"
        )
    ]
)
