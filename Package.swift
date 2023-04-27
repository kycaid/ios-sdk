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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.1/KYCAIDSDK.xcframework.zip",
            checksum: "3289772797e02a14ce4631b060692703f46a785b4c025e24074c53d3734e750f"
        )
    ]
)
