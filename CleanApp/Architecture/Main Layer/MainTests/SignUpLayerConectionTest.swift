import XCTest
@testable import Main

final class SignUpLayerConectionTest: XCTestCase {

    func test_check_if_composer_contain_memory_leak() {
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpComposer.composeController(with: addAccountSpy)
        checkMemoryLeak(for: sut)
    }
}
