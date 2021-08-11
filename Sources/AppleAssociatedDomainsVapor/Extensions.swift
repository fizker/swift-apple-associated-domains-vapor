import AppleAssociatedDomains
import Vapor

public typealias AppleAppSiteAssociation = AppleAssociatedDomains.AppleAppSiteAssociation

extension AppleAppSiteAssociation: Content {
}

public extension AppleAppSiteAssociation {
	static let appleAppSiteAssociationPath: [PathComponent] = [ ".well-known", "apple-app-site-association" ]
	var appleAppSiteAssociationPath: [PathComponent] { Self.appleAppSiteAssociationPath }
}

public extension Application {
	func appleAppSiteAssociation(_ aasa: AppleAppSiteAssociation) {
		get(aasa.appleAppSiteAssociationPath) { _ in
			aasa
		}
	}

	func appleAppSiteAssociation(applinks: AppleAppSiteAssociation.AppLinks? = nil, appclips: AppleAppSiteAssociation.AppClips = [], webcredentials: AppleAppSiteAssociation.WebCredentials = []) {
		appleAppSiteAssociation(.init(applinks: applinks, appclips: appclips, webcredentials: webcredentials))
	}
}
