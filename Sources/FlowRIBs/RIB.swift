import SwiftUI

public protocol RIB {
    associatedtype State
    associatedtype Interactor: FlowRIBs.Interactor where Interactor.Router == Router
    associatedtype Router: FlowRIBs.Router
    associatedtype Environment
    
    func build(environment: Environment) -> Router
}

public protocol PresentableRIB: RIB {
    associatedtype ViewState
    associatedtype Presenter: FlowRIBs.Presenter where Presenter.State == State, Presenter.ViewState == ViewState
}

public protocol DisplaybleRIB: RIB {
    associatedtype View: SwiftUI.View
}

public extension PresentableRIB {
    typealias Store = FlowRIBs.Store<State, ViewState>
}

public extension PresentableRIB where State == ViewState {
    typealias Presenter = Never
}
