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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.7.2/KYCAIDSDK.xcframework.zip",
            checksum: "ff352b93612132cb23411dec352c802d6352202ad6254b0fcd755fb14e03ce90"
        )
    ]
)
