import UIKit

public protocol Router: AnyObject {
	var name: String { get }

	func load()
	func unload()
	
	func attach(child: Router, identifier: ChildIdentifier)
	func detach(child identifier: ChildIdentifier)
}

public extension Router {
	var name: String {
		"\(type(of: self))"
	}
}
