import UIKit

extension PresentationContexts {
	public final class TabItem: PresentationContext {
		private let source: UITabBarController
		
		public init(source: UITabBarController) {
			self.source = source
		}
		
		public func present(_ view: UIViewController, animated: Bool, completion: Completion?) {
			if source.viewControllers == nil {
				source.viewControllers = [view]
			} else {
				source.viewControllers?.append(view)
			}
			
			completion?()
		}
		
		public func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?) {
			guard let index = source.viewControllers?.firstIndex(of: view) else { return }
			
			source.viewControllers?.remove(at: index)
			completion?()
		}
	}
}
