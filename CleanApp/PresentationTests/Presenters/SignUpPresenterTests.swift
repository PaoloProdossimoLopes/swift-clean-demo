import XCTest

@testable import Presentation

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
    
    func test_signUp_should_show_error_message_if_passwordConsfirmation_is_not_match() {
        makeSUT()
        let model = SignUpModel(name: "any_name", emaail: "any_email@mail.com", password: "any_password", passwordConfimation: "any_passwords")
        sut.signUp(model: model)
        let alertModel = AlertModel(title: "Falha na validaçao", message: "Falha ao confirmar senha")
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
}

private extension SignUpPresenterTests {
    func makeSUT() {
        self.alertViewSpy = AlertViewSpy()
        self.sut = SignUpPresenter(alertView: alertViewSpy)
    }
}





final class AlertViewSpy: AlertView {
    
    var model: AlertModel?
    
    func showMessage(model: AlertModel) {
        self.model = model
    }
}
