import SwiftUI
import UIKit

public typealias Completion = () -> Void

public protocol PresentationContext {
	func present(_ view: UIViewController, animated: Bool, completion: Completion?)
	func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?)
}

public protocol NavigableContext: PresentationContext {
	var navigationController: ObservableNavigationController { get }
}

public extension PresentationContext {
	func present<Target: View>(_ view: Target) {
		present(UIHostingController(rootView: view), animated: true, completion: nil)
	}
	
	func dismiss<Target: View>(_ view: Target) {
		dismiss(UIHostingController(rootView: view), animated: true, completion: nil)
	}
}

public extension PresentationContext {
	func present(_ view: UIViewController, animated: Bool = true, completion: Completion? = nil) {
		present(view, animated: animated, completion: completion)
	}
	
	func dismiss(_ view: UIViewController, animated: Bool = true, completion: Completion? = nil) {
		dismiss(view, animated: animated, completion: completion)
	}
}

public enum PresentationContexts {}

final class HostingController<Content: View>: UIHostingController<Content> {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
}
