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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.5/KYCAIDSDK.xcframework.zip",
            checksum: "fdcda49acaf805372839186b930038521046ca9c7e992618e5c0eb474a552e95"
        )
    ]
)
