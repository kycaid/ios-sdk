// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "KYCAIDSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "KYCAIDSDK",
            targets: ["KYCAIDSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://nsbeep.com/KYCAIDSDK.xcframework.zip",
            checksum: "4cc7572150394365f04e3657a2d2d5bcc5842e3df0cc1834ccb9308dc2e99f36"
        )
    ]
)
