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
            checksum: "87c71e9cde58641cf3cfe5ed5c6ef81b244cc99a5c8eed8e6b8ca58175179825"
        )
    ]
)
