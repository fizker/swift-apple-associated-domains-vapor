# swift-apple-associated-domains-vapor

[Vapor][vapor] helpers for serving [Apple´s Associated Domains specification][AAD].

The code for the JSON model is found at [https://github.com/fizker/swift-apple-associated-domains][swift-AAD].

## Usage

### Declare SwiftPM dependency with release tag

Add this repository to the Package.swift manifest of your project:

```
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MyServer",
  dependencies: [
    .package(url: "https://github.com/fizker/swift-apple-associated-domains-vapor.git", .upToNextMajor(from: "1.0.0")),
  ],
  targets: [
    .target(name: "MyTarget", dependencies: [
      .product(name: "AppleAssociatedDomainsVapor", package: "swift-apple-associated-domains-vapor"),
    ]),
  ]
)
```

### Create the specification

Note: This is the sample from https://developer.apple.com/documentation/Xcode/supporting-associated-domains#Add-the-Associated-Domain-File-to-Your-Website
```
import AppleAssociatedDomainsVapor

let spec = AppleAppSiteAssociation(
	applinks: .init(details: [
		.init(
			appIDs: [ "ABCDE12345.com.example.app", "ABCDE12345.com.example.app2" ],
			components: [
				.init(
					fragment: "no_universal_links",
					isExcludingMatches: true,
					comment: "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/buy/*",
					comment: "Matches any URL whose path starts with /buy/"
				),
				.init(
					path: "/help/website/*",
					isExcludingMatches: true,
					comment: "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/help/*",
					query: [ "articleNumber": "????" ],
					comment: "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters"
				),
			]
		),
	]),
	appclips: ["ABCED12345.com.example.MyApp.Clip"],
	webcredentials: [ "ABCDE12345.com.example.app" ]
)
```

### Serve the file

This package adds a convenience function to `Vapor.Application`, which makes it very easy to serve specs.

```
app.appleAppSiteAssociation(spec)
```

Alternatively, the spec can be built directly into the call.

```
import AppleAssociatedDomainsVapor

app.appleAppSiteAssociation(
	applinks: .init(details: [
		.init(
			appIDs: [ "ABCDE12345.com.example.app", "ABCDE12345.com.example.app2" ],
			components: [
				.init(
					fragment: "no_universal_links",
					isExcludingMatches: true,
					comment: "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/buy/*",
					comment: "Matches any URL whose path starts with /buy/"
				),
				.init(
					path: "/help/website/*",
					isExcludingMatches: true,
					comment: "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link"
				),
				.init(
					path: "/help/*",
					query: [ "articleNumber": "????" ],
					comment: "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters"
				),
			]
		),
	]),
	appclips: ["ABCED12345.com.example.MyApp.Clip"],
	webcredentials: [ "ABCDE12345.com.example.app" ]
)
```

All three keys are optional, so it is only necessary to add the one you need.

```
import AppleAssociatedDomainsVapor

app.appleAppSiteAssociation(appclips: ["ABCED12345.com.example.MyApp.Clip"])
```

[vapor]: https://vapor.codes
[AAD]: https://developer.apple.com/documentation/Xcode/supporting-associated-domains
[swift-AAD]: https://github.com/fizker/swift-apple-associated-domains
