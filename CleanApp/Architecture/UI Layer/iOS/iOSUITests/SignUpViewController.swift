import XCTest
import Presentation
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
}

private extension SignUpViewControllerTests {
    func makeSUT() {
        sut = .init()
        _ = sut.view
    }
}
