import XCTest

final class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        
        let model = SignUpModel(name: "", emaail: "any_email@mail.com", password: "any_password", passwordConfimation: "any_password")
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo Nome é obrigatorio")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
}













struct AlertModel: Equatable {
    var title: String
    var message: String
}

protocol AlertView {
    func showMessage(model: AlertModel)
}

struct SignUpModel {
    var name: String?
    var emaail: String?
    var password: String?
    var passwordConfimation: String?
}

final class SignUpPresenter {
    
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(model: SignUpModel) {
        
        if let name = model.name, name.isEmpty {
            let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo Nome é obrigatorio")
            alertView.showMessage(model: alertModel)
        }
    }
}



final class AlertViewSpy: AlertView {
    
    var model: AlertModel?
    
    func showMessage(model: AlertModel) {
        self.model = model
    }
}
