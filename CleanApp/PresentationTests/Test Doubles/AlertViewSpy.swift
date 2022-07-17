@testable import Presentation

final class AlertViewSpy: AlertView {
    
    var model: AlertModel?
    
    private var emit: ((AlertModel) -> Void)?
    func observer(_ completion: @escaping (AlertModel) -> Void) {
        emit = completion
    }
    
    func showMessage(model: AlertModel) {
        self.model = model
        self.emit?(model)
    }
}
