public protocol Interactor: AnyObject {
	associatedtype Router
	
	func start(router: Router)
	func stop()
}
