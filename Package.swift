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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.4/KYCAIDSDK.xcframework.zip",
            checksum: "d9f1c1a61b24ae4e3e8aebc29907e3970a75e2c437abdfea08f0655051fab957"
        )
    ]
)
