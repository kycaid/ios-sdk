// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "KYCAIDSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "KYCAIDSDK",
            targets: ["KycaidSDKSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", exact: "4.5.2")
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.4.1/KYCAIDSDK.xcframework.zip",
            checksum: "d2cdca855479361dcfb70bc0023bc002879ee6ff6bc78b04b4e72453fb1cb1a0"
        ),
        .target(
            name: "KycaidSDKSwift",
            dependencies: [
                "KYCAIDSDK",
                .product(name: "Lottie", package: "lottie-spm")
            ],
            path: "Sources/KYCAID"
        )
    ]
)
