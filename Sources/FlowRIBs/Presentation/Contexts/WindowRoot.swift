import UIKit

extension PresentationContexts {
	public final class WindowRoot: PresentationContext {
		private let source: UIWindow
		
		public init(source: UIWindow) {
			self.source = source
		}
		
		public func present(_ view: UIViewController, animated: Bool, completion: Completion?) {
			source.rootViewController = view
			
			if animated {
				UIView.transition(
					with: source,
					duration: 0.25,
					options: .transitionCrossDissolve,
					animations: nil,
					completion: nil
				)
			}
			
			completion?()
		}
		
		// This context won't dismiss to prevent the key window to not have a root, otherwise this context
		// would've been unusable.
		public func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?) {
			completion?()
		}
	}
}
