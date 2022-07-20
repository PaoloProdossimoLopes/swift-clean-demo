import XCTest
@testable import Main

final class SignUpLayerConectionTest: XCTestCase {

    func test_() {
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composeController(with: addAccountSpy)
        checkMemoryLeak(for: sut)
    }
}
