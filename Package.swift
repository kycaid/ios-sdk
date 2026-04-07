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
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.2")
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.4.3/KYCAIDSDK.xcframework.zip",
            checksum: "e82fa39b034fbda32a8cde84db96eec07d83160efb79b0a9d0fd0e525cc73784"
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
