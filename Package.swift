// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MentionmeSwift",
    products: [
        .library(
            name: "MentionmeSwift",
            targets: [
                "MentionmeSwift"
            ]
        )
    ],
    targets: [
        .target(
            name: "MentionmeSwift",
            path: "MentionmeSwift"
        )
    ]
)

