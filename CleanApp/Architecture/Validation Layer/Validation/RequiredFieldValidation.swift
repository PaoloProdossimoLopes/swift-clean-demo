//
//  RequiredFieldValidation.swift
//  Main
//
//  Created by Paolo Prodossimo Lopes on 20/07/22.
//

import Presentation

public final class RequiredFieldValidation: Validation {
    
    private let field: String
    private let label: String
    
    public init(field: String, for label: String) {
        self.field = field
        self.label = label
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fName = data?[field] as? String, !fName.isEmpty else {
            return "O Campo \(label) é obrigatório"
        }
        return nil
    }
}
