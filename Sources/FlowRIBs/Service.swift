open class Service {
	public private(set) weak var router: Router?
	
	public init() {}
	
	open func didStart() {
		// No-op
	}
	
	open func didStop() {
		// No-op
	}
	
	func start(router: Router) {
		self.router = router
		didStart()
	}
	
	func stop() {
		didStop()
	}
}

open class ComponentService<Component>: Service {
	public private(set) var component: Component?
	
	public init(component: Component) {
		self.component = component
	}
	
	override func stop() {
		super.stop()
		component = nil
	}
}
