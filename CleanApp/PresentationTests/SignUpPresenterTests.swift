import XCTest

final class SignUpPresenterTests: XCTestCase {
    
    private var sut: SignUpPresenter!
    private var alertViewSpy: AlertViewSpy!
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        makeSUT()
        let model = SignUpModel(name: "", emaail: "any_email@mail.com", password: "any_password", passwordConfimation: "any_password")
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo Nome é obrigatorio")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        makeSUT()
        let model = SignUpModel(name: "any_name", emaail: "", password: "any_password", passwordConfimation: "any_password")
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo Email é obrigatorio")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        makeSUT()
        let model = SignUpModel(name: "any_name", emaail: "any_email@mail.com", password: "", passwordConfimation: "any_password")
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo de Senha é obrigatorio")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_passwordConsfirmation_is_not_provided() {
        makeSUT()
        let model = SignUpModel(name: "any_name", emaail: "any_email@mail.com", password: "any_password", passwordConfimation: "")
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "O campo de confirmaçao de senha é obrigatorio")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
}

private extension SignUpPresenterTests {
    func makeSUT() {
        self.alertViewSpy = AlertViewSpy()
        self.sut = SignUpPresenter(alertView: alertViewSpy)
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
        if let message = validate(model: model) {
            let alertModel = AlertModel(title: "Falha na validaçao", message: message)
            alertView.showMessage(model: alertModel)
        }
    }
    
    private func validate(model: SignUpModel) -> String? {
        if let name = model.name, name.isEmpty {
            return "O campo Nome é obrigatorio"
        }
        
        if let email = model.emaail, email.isEmpty {
            return "O campo Email é obrigatorio"
        }
        
        if let password = model.password, password.isEmpty {
            return "O campo de Senha é obrigatorio"
        }
        
        if let confirmation = model.passwordConfimation, confirmation.isEmpty {
            return "O campo de confirmaçao de senha é obrigatorio"
        }
        
        return nil
    }
}



final class AlertViewSpy: AlertView {
    
    var model: AlertModel?
    
    func showMessage(model: AlertModel) {
        self.model = model
    }
}
