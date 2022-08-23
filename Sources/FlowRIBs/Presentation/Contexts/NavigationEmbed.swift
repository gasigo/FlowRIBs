import UIKit

extension PresentationContexts {
	public final class NavigationEmbed: NavigableContext {
		public let navigationController: ObservableNavigationController
		private let embeddedContext: PresentationContext
		
		public init(embeddedContext: PresentationContext) {
			self.embeddedContext = embeddedContext
			navigationController = ObservableNavigationController()
		}
		
		public func present(_ view: UIViewController, animated: Bool, completion: Completion?) {
			navigationController.setViewControllers([view], animated: animated)
			embeddedContext.present(navigationController, animated: animated, completion: completion)
		}
		
		public func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?) {
			embeddedContext.dismiss(view, animated: animated, completion: completion)
		}
	}
}
