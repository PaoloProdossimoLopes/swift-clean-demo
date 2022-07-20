@testable import Presentation

final class LoadingViewSpy {
    
    //MARK: - Properties
    var isLoading: Bool = false
    
    //MARK: - Observer Pattern
    typealias ObserverCompletion = ((Bool) -> Void)
    
    var emit: ObserverCompletion?
    
    func observer(_ completion: @escaping ObserverCompletion) {
        emit = completion
    }
}

//MARK: - LoadingView
extension LoadingViewSpy: LoadingView {
    func display(isLoading: Bool) {
        self.isLoading = isLoading
        emit?(isLoading)
    }
}
