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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.6/KYCAIDSDK.xcframework.zip",
            checksum: "9126828870fa067e1956fbb74989242baca57f9d4835147bfb7117a59b0bc9e1"
        )
    ]
)
