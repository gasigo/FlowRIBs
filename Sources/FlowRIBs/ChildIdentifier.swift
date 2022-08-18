public struct ChildIdentifier: Hashable, ExpressibleByStringLiteral {
	let value: String
	
	init(child: Router) {
		value = Unmanaged.passUnretained(child as AnyObject).toOpaque().debugDescription
	}
	
	init() {
		value = "<undefined>"
	}
	
	public init(stringLiteral: String) {
		value = stringLiteral
	}
}
