//
//  RequredFieldValidationTests.swift
//  Main
//
//  Created by Paolo Prodossimo Lopes on 20/07/22.
//

import XCTest
@testable import Validation

final class RequredFieldValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = RequiredFieldValidation(field: "", for: "Email")
        let errorMessage = sut.validate(data: ["name": "paolo"])
        XCTAssertNotNil(errorMessage)
        XCTAssertEqual(errorMessage, "O Campo Email é obrigatório")
    }
    
    func test_validate_should_return_error_if_correct_field_label() {
        let label = "Senha"
        let sut = RequiredFieldValidation(field: "", for: label)
        let errorMessage = sut.validate(data: ["name": "paolo"])
        XCTAssertNotNil(errorMessage)
        XCTAssertTrue(errorMessage!.contains(label))
    }
    
    func test_validate_should_return_error_if_field_is_provided() {
        let sut = RequiredFieldValidation(field: "email", for: "Email")
        let errorMessage = sut.validate(data: ["email": "paolo@email.com"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_error_if_no_data_is_provided() {
        let sut = RequiredFieldValidation(field: "", for: "")
        let errorMessage = sut.validate(data:nil)
        XCTAssertNotNil(errorMessage)
    }
}

