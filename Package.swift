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
            targets: ["KycaidSDKSwift"]),
        .library(
            name: "KYCAIDSDKNFC",
            targets: ["KycaidNFCSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.5.0"..<"4.6.0"),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL-Package.git", .upToNextMinor(from: "3.3.1000"))
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0/KYCAIDSDK.xcframework.zip",
            checksum: "a4af68ce7882ff7080b8839b8a11f2024da062e539b6a5de91f1d007c4c49195"
        ),
        .binaryTarget(
            name: "KYCAIDSDKNFC",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0/KYCAIDSDKNFC.xcframework.zip",
            checksum: "03ad241354ac6f848a5b0d79d582d1f66dd51feaf487e7e7997a5e0a6a6b8d1c"
        ),
        .target(
            name: "KycaidSDKSwift",
            dependencies: [
                "KYCAIDSDK",
                .product(name: "Lottie", package: "lottie-spm")
            ],
            path: "Sources/KYCAID"
        ),
        .target(
            name: "KycaidNFCSwift",
            dependencies: [
                "KYCAIDSDKNFC",
                "KycaidSDKSwift",
                .product(name: "OpenSSL", package: "OpenSSL-Package")
            ],
            path: "Sources/KYCAIDNFC"
        )
    ]
)
