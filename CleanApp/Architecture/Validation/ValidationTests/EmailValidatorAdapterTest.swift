import XCTest
@testable import Validation

final class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_email()  {
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "email@email.com"))
    }
}
