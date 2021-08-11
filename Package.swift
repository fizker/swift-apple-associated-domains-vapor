// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-apple-associated-domains-vapor",
	platforms: [
		.macOS(.v10_15),
	],
	products: [
		.library(
			name: "AppleAssociatedDomainsVapor",
			targets: [
				"AppleAssociatedDomainsVapor",
			]
		),
	],
	dependencies: [
		.package(url: "https://github.com/fizker/swift-apple-associated-domains.git", .upToNextMajor(from: "1.0.0")),
		.package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "4.0.0")),
	],
	targets: [
		.target(
			name: "AppleAssociatedDomainsVapor",
			dependencies: [
				.product(name: "AppleAssociatedDomains", package: "swift-apple-associated-domains"),
				.product(name: "Vapor", package: "vapor"),
			]
		),
	]
)
