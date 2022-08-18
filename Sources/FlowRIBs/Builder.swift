public protocol Builder {
	associatedtype Dependency

	func build(dependency: Dependency) -> Router
}
