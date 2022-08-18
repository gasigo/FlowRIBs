import UIKit
import Combine

open class ObservableNavigationController: UINavigationController {
	var stackPublisher: AnyPublisher<[UIViewController], Never> {
		stackSubject.eraseToAnyPublisher()
	}

	private lazy var stackSubject = PassthroughSubject<[UIViewController], Never>()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	public override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		stackSubject.send(viewControllers)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
		super.setViewControllers(viewControllers, animated: animated)
		stackSubject.send(viewControllers)
	}
	
	open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: animated)
		stackSubject.send(viewControllers)
	}
	
	open override func popViewController(animated: Bool) -> UIViewController? {
		let viewController = super.popViewController(animated: animated)
		stackSubject.send(viewControllers)
		return viewController
	}
	
	open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
		let stack = super.popToRootViewController(animated: animated)
		stackSubject.send(viewControllers)
		return stack
	}
	
	open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
		let stack = super.popToViewController(viewController, animated: animated)
		stackSubject.send(viewControllers)
		return stack
	}
}
