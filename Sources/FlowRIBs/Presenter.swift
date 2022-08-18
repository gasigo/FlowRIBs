public protocol Presenter {
	associatedtype State
	associatedtype ViewState
	
	func format(state: State) -> ViewState
}
