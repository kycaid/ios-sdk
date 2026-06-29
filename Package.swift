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
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0-rc3/KYCAIDSDK.xcframework.zip",
            checksum: "2cee248f37a9d23dd4c5092782b3e52b81b903ff0c9a9d870588a09883c3be13"
        ),
        .binaryTarget(
            name: "KYCAIDSDKNFC",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0-rc3/KYCAIDSDKNFC.xcframework.zip",
            checksum: "20451955e4c86421426d3f07b42874d6baabfb4eaf89a854dc1491f1c9d9b726"
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
