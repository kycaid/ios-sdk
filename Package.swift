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
        .package(url: "https://github.com/AndyQ/NFCPassportReader", exact: "2.3.0")
    ],
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0-rc2/KYCAIDSDK.xcframework.zip",
            checksum: "57850ffa9f7aa7e4dfb641e4f35f20cf55cbe9b073e78795a0efe19aa1fe0dcd"
        ),
        .binaryTarget(
            name: "KYCAIDSDKNFC",
            url: "https://github.com/kycaid/ios-sdk/releases/download/26.7.0-rc2/KYCAIDSDKNFC.xcframework.zip",
            checksum: "fd0d007ff9334b68e40a1ab6d2a7281ccee62eb653b2bdbca1ab4c8bf4098f5c"
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
                .product(name: "NFCPassportReader", package: "NFCPassportReader")
            ],
            path: "Sources/KYCAIDNFC"
        )
    ]
)
