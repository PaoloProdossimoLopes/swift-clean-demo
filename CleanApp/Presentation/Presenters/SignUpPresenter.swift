import Foundation

final class SignUpPresenter {
    
    private let alertView: AlertView
    private var eValidator: EmailValidator
    
    init(alertView: AlertView, eValidator: EmailValidator) {
        self.alertView = alertView
        self.eValidator = eValidator
    }
    
    func signUp(model: SignUpModel) {
        if let message = validate(model: model) {
            let alertModel = AlertModel(title: "Falha na validaçao", message: message)
            alertView.showMessage(model: alertModel)
        }
    }
    
    private func validate(model: SignUpModel) -> String? {
        guard let name = model.name, !name.isEmpty else {
            return "O campo Nome é obrigatorio"
        }
        
        guard let email = model.emaail, !email.isEmpty else {
            return "O campo Email é obrigatorio"
        }
        
        guard let password = model.password, !password.isEmpty else {
            return "O campo de Senha é obrigatorio"
        }
        
        guard let confirmation = model.passwordConfimation, !confirmation.isEmpty else {
            return "O campo de confirmaçao de senha é obrigatorio"
        }
        
        guard model.password == model.passwordConfimation else {
            return "Falha ao confirmar senha"
        }
        
        if !eValidator.isValid(email: model.emaail!) {
            return "Email invalido"
        }
        
        return nil
    }
}
