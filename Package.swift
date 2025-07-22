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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.7.1/KYCAIDSDK.xcframework.zip",
            checksum: "e96769f7b504072d0e37a99a189dca398a706daa7cd49fdd6ec4a1e316a20b6f"
        )
    ]
)
