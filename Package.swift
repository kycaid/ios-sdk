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
            url: "https://github.com/kycaid/ios-sdk/releases/download/1.0.1/KYCAIDSDK.xcframework.zip",
            checksum: "918aa58624a0137808e4e645ef7a9ca1c054b13d6e93f1339e3ae5ee2645fb5d"
        )
    ]
)
