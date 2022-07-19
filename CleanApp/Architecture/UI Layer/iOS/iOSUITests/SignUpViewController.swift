import XCTest
import Presentation
import Domain
@testable import iOSUI

final class SignUpViewControllerTests: XCTestCase {
    
    private var sut: SignUpViewController!
    
    override func setUp() {
        makeSUT()
    }
    
    func test_loading_is_hidden_on_start() {
        XCTAssertFalse(sut.loadingView.isAnimating)
    }
    
    func test_sut_implements_loadingView_protocol() {
        XCTAssert(sut.asOpaque is LoadingView)
    }
    
    func test_sut_implements_alertView_protocol() {
        XCTAssert(sut.asOpaque is AlertView)
    }
    
    func test_save_button_calls_signUp_on_tap() {
        var count = 0
        sut = .init(signUp: nil)
        sut.signUp = { _ in count += 1 }
        sut.viewDidLoad()
        sut.saveButton.simulateTap()
        XCTAssertEqual(count, 1)
    }
    
    func test_saveButton_cells_signUp_on_tap() {
        var signUpModel: SignUpModel?
        sut.signUp = { signUpModel = $0 }
        sut.saveButton.simulateTap()
        let expected = SignUpModel(
            name: sut.nameTextField.text, emaail: sut.emailTextField.text,
            password: sut.passwordTextField.text, passwordConfimation: sut.passwordConfimationTextField.text
        )
        XCTAssertEqual(expected, signUpModel)
    }
}


//MARK: - Helper
private extension SignUpViewControllerTests {
    func makeSUT() {
        sut = .init(signUp: nil)
        _ = sut.view
    }
}
