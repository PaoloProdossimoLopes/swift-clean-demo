//
//  CompareFieldValidationTest.swift
//  Main
//
//  Created by Paolo Prodossimo Lopes on 20/07/22.
//

import XCTest
@testable import Validation

final class CompareFieldValidationTest: XCTestCase {
    
    func test_() {
        let sut = CompareFieldValidation("password", compareWith: "passwordConfirmation", for: "senha")
        let error = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertNotNil(error)
        XCTAssertEqual(error!, "O campo senha é invalido")
    }

    func test_2() {
        let sut = CompareFieldValidation("password", compareWith: "passwordConfirmation", for: "Senha")
        let error = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertNotNil(error)
        XCTAssertEqual(error!, "O campo Senha é invalido")
    }
    
    func test_3() {
        let sut = CompareFieldValidation("password", compareWith: "passwordConfirmation", for: "Senha")
        let error = sut.validate(data: ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(error)
    }
}


import Presentation

public final class CompareFieldValidation: Validation {
    
    private let field: String
    private let compare: String
    private let label: String
    
    public init(_ field: String, compareWith fieldToCompare: String, for label: String) {
        self.field = field
        self.compare = fieldToCompare
        self.label = label
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let first = data?[field] as? String,
              let second = data?[compare] as? String, first == second else {
            return "O campo \(label) é invalido"
        }
        
        return nil
    }
}
