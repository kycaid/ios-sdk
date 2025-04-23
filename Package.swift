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
            url: "https://github.com/kycaid/ios-sdk/releases/download/2.0.2/KYCAIDSDK.xcframework.zip",
            checksum: "fabb53b8ddae7d96538e41f6858748b25322ca8a9063cfc9673f4d53c4db31e0"
        )
    ]
)
