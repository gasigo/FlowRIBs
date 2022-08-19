import SwiftUI
import UIKit

open class AbstractRouter<Dependency>: Router {
	public let dependency: Dependency
	public var presentedView: UIViewController?
	
	private var loadFunctions: [Completion] = []
	private var unloadFunctions: [Completion] = []
	private var children: [ChildIdentifier: Router] = [:]
	private var services: [Service] = []

	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
	open func didLoad() {
		// No-op
	}
	
	open func didUnload() {
		// No-op
	}
	
	public func load() {
		services.forEach { $0.start(router: self) }
		loadFunctions.forEach { $0() }
		didLoad()
	}
	
	public func unload() {
		unloadFunctions.forEach { $0() }
		didUnload()
		detachAll()
		services.forEach { $0.stop() }
		services.removeAll()
	}
	
	public func attach(child: Router, identifier: ChildIdentifier) {
		children[identifier] = child
		child.load()
	}
	
	public func detach(child identifier: ChildIdentifier) {
		guard let child = children[identifier] else { return }
		
		children[identifier] = nil
		child.unload()
	}
	
	public func detachAll() {
		children.keys.forEach { detach(child: $0) }
	}
}

public extension AbstractRouter {
	func routing<I: Interactor>(for interactor: I) -> Self {
		assert(self is I.Router)
		loadFunctions.append { [unowned self] in (self as? I.Router).map(interactor.start(router:)) }
		unloadFunctions.append(interactor.stop)
		return self
	}
	
	func presenting(view: UIViewController, using context: PresentationContext, animated: Bool = true) -> Self {
		presentedView = view
		loadFunctions.insert({ context.present(view) }, at: .zero)
		unloadFunctions.append { context.dismiss(view, animated: animated, completion: nil) }
		return self
	}
	
	func presenting<Target: View>(view: Target, using context: PresentationContext, animated: Bool = true) -> Self {
		presenting(view: UIHostingController(rootView: view), using: context, animated: animated)
	}
	
	func registering(services: [Service]) -> Self {
		self.services += services
		return self
	}
}
