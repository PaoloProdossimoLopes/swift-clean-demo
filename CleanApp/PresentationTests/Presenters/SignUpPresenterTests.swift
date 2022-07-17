import XCTest

import Domain
import Data

@testable import Presentation

final class SignUpPresenterTests: XCTestCase {
    
    private var sut: SignUpPresenter!
    private var alertViewSpy: AlertViewSpy!
    private var eValidtorSpy: EmailValidatorSpy!
    private var addAccountSpy: AddAccountSpy!
    private var loadingViewSpy: LoadingViewSpy!
    
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
    
    func test_signUp_should_call_addAccount_with_correct_values() {
        let model = makeSignUpModel()
        let accountModel = AddAccountModel(
            name: model.name!, email: model.emaail!,
            password: model.password!, passwordConfirmation: model.passwordConfimation!
        )
        
        sut.signUp(model: model)
        
        XCTAssertEqual(addAccountSpy.model, accountModel)
    }
    
    func test_signUp_should_show_loading_when_AddAccount_wasCalled() {
        sut.signUp(model: makeSignUpModel())
        XCTAssertTrue(loadingViewSpy.isLoading)
    }
    
    func test_signUp_should_hide_loading_when_AddAccount_respond_with_error() {
        let model = AlertModel(
            title: "Error",
            message: "Algo Inesperado aconteceu, tente novamente em alguns instantes"
        )
        
        let expect = XCTestExpectation(description: "waiting")
        alertViewSpy.observer { _ in
            XCTAssertFalse(self.loadingViewSpy.isLoading)
            expect.fulfill()
        }
        
        sut.signUp(model: makeSignUpModel())
        addAccountSpy.completeWith(.unxpected)
        
        wait(for: [expect], timeout: 1)
    }
    
//    func test_signUp_should_hide_loading_when_AddAccount_respond_with_success() {
//        sut.signUp(model: makeSignUpModel())
//        XCTAssertTrue(loadingViewSpy.isLoading)
//    }
    
    func test_signUp_should_show_error_message_if_addAccount_fail() {
        let model = AlertModel(
            title: "Error",
            message: "Algo Inesperado aconteceu, tente novamente em alguns instantes"
        )
        
        let expect = XCTestExpectation(description: "waiting")
        alertViewSpy.observer {
            XCTAssertEqual($0, model)
            expect.fulfill()
        }
        
        sut.signUp(model: makeSignUpModel())
        addAccountSpy.completeWith(.unxpected)
        
        wait(for: [expect], timeout: 1)
    }
    
    func test_sut_does_retain_cicle() {
        let alertViewSpy = AlertViewSpy()
        let eValidtorSpy = EmailValidatorSpy()
        let addAccountSpy = AddAccountSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut = SignUpPresenter(
            alertView: alertViewSpy,
            eValidator: eValidtorSpy,
            addAccount: addAccountSpy,
            loadingView: loadingViewSpy
        )
        addTeardownBlock { [weak sut] in
            XCTAssertNil(
                sut,
                "❌ ERROR: Instance of \(sut!) does not deallocated ..."
            )
        }
        sut.signUp(model: makeSignUpModel())
    }
}

private extension SignUpPresenterTests {
    func makeSUT() {
        addAccountSpy = .init()
        eValidtorSpy = .init()
        alertViewSpy = .init()
        loadingViewSpy = .init()
        sut = SignUpPresenter(
            alertView: alertViewSpy,
            eValidator: eValidtorSpy,
            addAccount: addAccountSpy,
            loadingView: loadingViewSpy
        )
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




final class AddAccountSpy: AddAccount {
    
    var model: AddAccountModel?
    var expected: AddCompletionBlock?
    
    func add(model: AddAccountModel, _ completion: @escaping AddCompletionBlock) {
        self.model = model
        expected = completion
    }
    
    func completeWith(_ error: DomainError) {
        expected?(.failure(error))
    }
    
    func completeWith(_ succes: AccountModel) {
        expected?(.success(succes))
    }
}


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



final class EmailValidatorSpy: EmailValidator {
    
    var email: String?
    var isValid = true
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
}


final class LoadingViewSpy: LoadingView {
    
    var isLoading: Bool = false
    
    func display(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
}
