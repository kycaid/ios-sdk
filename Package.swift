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
    dependencies: [
        .package(url: "https://github.com/roberthein/TinyConstraints", from: "4.0.2")
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.1")
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.1")
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.0/KYCAIDSDK.xcframework.zip",
            checksum: "aba01c0bfaa678b1ea2be59a5ce9563281b2fb298f299576bb0449664c80aee7"
        )
    ]
)
