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
    targets: [
        .binaryTarget(
            name: "KYCAIDSDK",
            url: "",
            checksum: "b3e42086cf1d3f9c8d56a2553f6e7425676e0509871e21b4d94a59deff93fea1"
        )
    ]
)
