// swift-tools-version:5.8

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "ScadeNASA",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ScadeNASA",
            type: .static,
            targets: [
                "ScadeNASA"
            ]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/jblanked/EasySCADE", branch: "main")
    ],
    targets: [
        .target(
            name: "ScadeNASA",
            dependencies: ["EasySCADE"],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)