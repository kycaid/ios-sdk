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
            url: "https://github.com/kycaid/ios-sdk/releases/tag/untagged-bcb97fed78084fe7d93a/KYCAIDSDK.xcframework.zip",
            checksum: "e75e28170e38ba46210a6af245b36cc25c1426385ae5fe4e195f99b1893ea4aa"
        )
    ]
)
