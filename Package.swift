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
            targets: ["KycaidSDKSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.1"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.1"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.21.1"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.8.0")
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.10.0/KYCAIDSDK.xcframework.zip",
            checksum: "512ca393d36de4365e5bf0eaa42db604ff412bdbb0ab5631fd71e19a166209ea"
        ),
        .target(
            name: "KycaidSDKSwift",
            dependencies: [
                "KYCAIDSDK",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxRelay", package: "RxSwift"),
                .product(name: "Lottie", package: "lottie-spm"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SDWebImageSVGCoder", package: "SDWebImageSVGCoder")
            ],
            path: "Sources/KYCAID"
        )
    ]
)
