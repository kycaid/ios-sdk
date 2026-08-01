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
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.2/KYCAIDSDK.xcframework.zip",
            checksum: "f49d49bb364ce1de02bcce8e62ec00cec81646ff2d827a591376881237442597"
        ),
        .binaryTarget(
            name: "KYCAIDSDKNFC",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.2/KYCAIDSDKNFC.xcframework.zip",
            checksum: "c06fb9f2f5cc41fbdad5b80fb52d59bd2f9b07888f92d2a04f7be5d427fd844b"
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
