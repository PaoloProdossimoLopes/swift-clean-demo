import Presentation

final class EmailValidatorAdapter: EmailValidator {
    func isValid(email: String) -> Bool {
        return false
    }
}
