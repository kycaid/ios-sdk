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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.6/KYCAIDSDK.xcframework.zip",
            checksum: "15c724ce14c660bd93df77c23f9cc8be0b04b1d385df49a2c8496cf19e78180e"
        )
    ]
)
