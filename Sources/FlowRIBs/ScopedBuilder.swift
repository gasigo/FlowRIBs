import Foundation
public struct ScopedBuilder<Args> {
	private let buildFunction: (Args) -> Router
	
	init(buildFunction: @escaping (Args) -> Router) {
		self.buildFunction = buildFunction
	}
	
	public func build(args: Args) -> Router {
		buildFunction(args)
	}
}

public extension Builder {
	func scoped<T>(_ makeDependency: @escaping (T) -> Dependency) -> ScopedBuilder<T> {
		ScopedBuilder { [self] args -> Router in
			build(dependency: makeDependency(args))
		}
	}
}
