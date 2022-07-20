@testable import Presentation

final class EmailValidatorSpy: EmailValidator {
    
    var email: String?
    var isValid = true
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
}
