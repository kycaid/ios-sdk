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
            url: "https://github.com/kycaid/ios-sdk/releases/download/25.9.14/KYCAIDSDK.xcframework.zip",
            checksum: "362d7f62c3e68032f9987a93b440be5fe42320eff8361827a3c0dfee3bc56233"
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
