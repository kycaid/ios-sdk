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
            targets: ["KYCAID"])
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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.6/KYCAIDSDK.xcframework.zip",
            checksum: "f31a631ec15b8f4681a72c917de58655b914b4b6f827034a1987c5427bb4ce88"
        ),
        .target(
            name: "KYCAID",
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
