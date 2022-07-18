import XCTest
import Presentation
@testable import iOSUI

final class SignUpViewControllerTests: XCTestCase {
    
    private var sut: SignUpViewController!
    
    func test_loading_is_hidden_on_start() {
        sut = .init()
        _ = sut.view
        XCTAssertFalse(sut.loadingView.isAnimating)
    }
    
    func test_sut_implements_loadingView_protocol() {
        sut = .init()
        XCTAssert(sut.asOpaque is LoadingView)
    }
}


