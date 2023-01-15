import Combine

public final class Store<State, ViewState>: ObservableObject {
    @Published
    public private(set) var viewState: ViewState
    
    private let statePublisher: AnyPublisher<State, Never>
    private let presenter: (State) -> ViewState
    private var subscription: AnyCancellable?
    
    public init(
        initialState: State,
        statePublisher: AnyPublisher<State, Never>,
        presenter: @escaping (State) -> ViewState
    ) {
        self.statePublisher = statePublisher
        self.presenter = presenter
        self.viewState = presenter(initialState)
        
        subscribeToState()
    }
    
    private func subscribeToState() {
        subscription = statePublisher
            .map(presenter)
            .sink { [weak self] newState in
                self?.viewState = newState
            }
    }
}

public extension Store where State == ViewState {
    convenience init(
        initialState: State,
        statePublisher: AnyPublisher<State, Never>
    ) {
        self.init(initialState: initialState, statePublisher: statePublisher, presenter: { $0 })
    }
}
