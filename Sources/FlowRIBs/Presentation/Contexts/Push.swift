import UIKit
import Combine

extension PresentationContexts {
	public class Push: NavigableContext {
		public let navigationController: ObservableNavigationController
		private var dismissed: Completion
		private var subscription: AnyCancellable?

		public init(navigationController: ObservableNavigationController, dismissed: @escaping Completion) {
			self.navigationController = navigationController
			self.dismissed = dismissed
		}
		
		public convenience init(context: NavigableContext, dismissed: @escaping Completion) {
			self.init(navigationController: context.navigationController, dismissed: dismissed)
		}
		
		public func present(_ view: UIViewController, animated: Bool, completion: Completion?) {
			navigationController.pushViewController(view, animated: animated)
			completion?()
			
			subscription = navigationController.stackPublisher.sink { [weak self, weak view] stack in
				guard let view = view, stack.contains(view) else { return }
				self?.dismissed()
			}
		}
		
		public func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?) {
			guard let index = navigationController.viewControllers.firstIndex(of: view), index > 0 else { return }
			
			let popTarget = navigationController.viewControllers[index - 1]
			_ = navigationController.popToViewController(popTarget, animated: animated)
			completion?()
		}
	}
}
