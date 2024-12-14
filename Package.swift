// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YYImage",
    platforms: [.iOS(.v13), .macCatalyst(.v13), .visionOS(.v1), .tvOS(.v13), .watchOS(.v9)],
    products: [
        .library(name: "YYImage", targets: ["YYImage"]),
        .library(name: "YYImageSwift", targets: ["YYImageSwift"]),
    ],
    targets: [
        .target(
            name: "YYImage",
            dependencies: ["WebP", "WebPDecoder", "WebPDemux", "WebPMux"]
        ),
        .target(
            name: "YYImageSwift",
            dependencies: [.target(name: "YYImage")]
        ),
        .binaryTarget(name: "WebP", path: "Vendor/WebP.xcframework"),
        .binaryTarget(name: "WebPDecoder", path: "Vendor/WebPDecoder.xcframework"),
        .binaryTarget(name: "WebPDemux", path: "Vendor/WebPDemux.xcframework"),
        .binaryTarget(name: "WebPMux", path: "Vendor/WebPMux.xcframework"),
    ]
)
