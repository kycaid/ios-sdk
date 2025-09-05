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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.11/KYCAIDSDK.xcframework.zip",
            checksum: "9899896ca578b726d41319015a075ddaae55939b692c6e5084d6e2f9de06e6f4"
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
