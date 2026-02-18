// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GlimpseTranslate",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(url: "https://github.com/soffes/HotKey", from: "0.2.1"),
    ],
    targets: [
        .executableTarget(
            name: "GlimpseTranslate",
            dependencies: ["HotKey"],
            path: "Sources/GlimpseTranslate",
            resources: [
                .copy("../../Resources/Info.plist"),
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-sectcreate", "-Xlinker", "__TEXT", "-Xlinker", "__info_plist", "-Xlinker", "Resources/Info.plist"]),
            ]
        ),
    ]
)
