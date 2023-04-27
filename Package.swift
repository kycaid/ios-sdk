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
            checksum: "205bf5b076d86474789caf0cdce665ee9d3b00f67b260e7e1312de4487d24778"
        )
    ]
)
