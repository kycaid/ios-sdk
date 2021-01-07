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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.3/KYCAIDSDK.xcframework.zip",
            checksum: "0a4fd47c95b9588163504aa071f2230cbc2a706735882424b9deabf581d8327c"
        )
    ]
)
