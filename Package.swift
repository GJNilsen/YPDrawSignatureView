// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "YPDrawSignature",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "YPDrawSignature", targets: ["YPDrawSignature"])
    ],
    targets: [
      .target(
        name: "YPDrawSignature",
        path: "",
        sources: ["Sources"]
      )
    ],
    swiftLanguageVersions: [.v5]
)
