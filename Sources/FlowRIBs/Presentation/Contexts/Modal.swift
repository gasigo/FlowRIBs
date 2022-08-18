import UIKit

extension PresentationContexts {
	public final class Modal: PresentationContext {
		private let source: UIViewController
		private let modalDismissalObserver: ModalDismissalObserver
		
		public init(source: UIViewController, dismissed: @escaping Completion) {
			self.source = source
			self.modalDismissalObserver = ModalDismissalObserver(dismissed: dismissed)
		}
		
		public func present(_ view: UIViewController, animated: Bool, completion: Completion?) {
			view.presentationController?.delegate = modalDismissalObserver
			source.present(view, animated: animated, completion: completion)
		}
		
		public func dismiss(_ view: UIViewController, animated: Bool, completion: Completion?) {
			guard !view.isBeingDismissed else { return }
			
			source.dismiss(animated: animated) { [weak self] in
				completion?()
				self?.modalDismissalObserver.dismissed()
			}
		}
	}
}

private final class ModalDismissalObserver: NSObject, UIAdaptivePresentationControllerDelegate {
	let dismissed: Completion
	
	init(dismissed: @escaping Completion) {
		self.dismissed = dismissed
	}

	func presentationControllerDidDismiss(_ controller: UIPresentationController) {
		dismissed()
	}

	func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
		true
	}
}
