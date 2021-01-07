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
            url: "https://github.com/kycaid/ios-sdk/releases/tag/untagged-6d1be37f94874853fc02/KYCAIDSDK.xcframework.zip",
            checksum: "ac8dc290312be9920ec0c56b5b4ddeb0874d347ae5bd6986201bf3f33be2f901"
        )
    ]
)
