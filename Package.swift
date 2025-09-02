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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.0/KYCAIDSDK.xcframework.zip",
            checksum: "f8acffbd33bd21fefc437c1111d55b7e82716c777653b020af9904aebde7d290"
        )
    ]
)
