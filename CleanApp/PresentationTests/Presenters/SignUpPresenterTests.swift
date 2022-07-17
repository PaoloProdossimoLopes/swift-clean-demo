import XCTest

@testable import Presentation

final class SignUpPresenterTests: XCTestCase {
    
    private var sut: SignUpPresenter!
    private var alertViewSpy: AlertViewSpy!
    private var eValidtorSpy: EmailValidatorSpy!
    
    override func setUp() {
        makeSUT()
    }
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let model = makeSignUpModel(name: "")
        let alertModel = makeAlertModel("O campo Nome é obrigatorio")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let model = makeSignUpModel(email: "")
        let alertModel = makeAlertModel("O campo Email é obrigatorio")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let model = makeSignUpModel(password: "")
        let alertModel = makeAlertModel("O campo de Senha é obrigatorio")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_password_is_provided_empty() {
        let model = makeSignUpModel(password: nil)
        let alertModel = makeAlertModel("O campo de Senha é obrigatorio")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_passwordConsfirmation_is_not_provided() {
        let model = makeSignUpModel(confirmation: "")
        let alertModel = makeAlertModel("O campo de confirmaçao de senha é obrigatorio")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_show_error_message_if_passwordConsfirmation_is_not_match() {
        let model = makeSignUpModel(confirmation: "other_password")
        let alertModel = makeAlertModel("Falha ao confirmar senha")
        
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
    
    func test_signUp_should_call_email_validator_with_correct_email() {
        let model = makeSignUpModel()
        
        sut.signUp(model: model)
        
        XCTAssertEqual(eValidtorSpy.email, "any_email@mail.com")
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let model = makeSignUpModel()
        let alertModel = makeAlertModel("Email invalido")
        
        eValidtorSpy.isValid = false
        sut.signUp(model: model)
        
        XCTAssertEqual(alertViewSpy.model, alertModel)
    }
}

private extension SignUpPresenterTests {
    func makeSUT() {
        self.eValidtorSpy = EmailValidatorSpy()
        self.alertViewSpy = AlertViewSpy()
        self.sut = SignUpPresenter(alertView: alertViewSpy, eValidator: eValidtorSpy)
    }
    
    func makeSignUpModel(
        name: String? = "any_name",
        email: String? = "any_email@mail.com",
        password: String? = "any_password",
        confirmation: String? = "any_password"
    ) -> SignUpModel {
        SignUpModel(
            name: name,
            emaail: email,
            password: password,
            passwordConfimation: confirmation
        )
    }
    
    func makeAlertModel(_ message: String) -> AlertModel {
        AlertModel(title: "Falha na validaçao", message:message)
    }
}





final class AlertViewSpy: AlertView {
    
    var model: AlertModel?
    
    func showMessage(model: AlertModel) {
        self.model = model
    }
}



final class EmailValidatorSpy: EmailValidator {
    
    var email: String?
    var isValid = true
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}
