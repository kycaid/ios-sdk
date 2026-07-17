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
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.1/KYCAIDSDK.xcframework.zip",
            checksum: "2a476acda975a6def10df51c70a5939ddd381d109a2e3d5b34edef7a5c70d82b"
        ),
        .binaryTarget(
            name: "KYCAIDSDKNFC",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.1/KYCAIDSDKNFC.xcframework.zip",
            checksum: "d89059509c4eb90878d104896f8409daad3805dd95b813bad357f481c893ef9d"
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
