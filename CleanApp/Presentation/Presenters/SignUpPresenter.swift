import Foundation

final class SignUpPresenter {
    
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(model: SignUpModel) {
        if let message = validate(model: model) {
            let alertModel = AlertModel(title: "Falha na validaçao", message: message)
            alertView.showMessage(model: alertModel)
        }
    }
    
    private func validate(model: SignUpModel) -> String? {
        if let name = model.name, name.isEmpty {
            return "O campo Nome é obrigatorio"
        }
        
        if let email = model.emaail, email.isEmpty {
            return "O campo Email é obrigatorio"
        }
        
        if let password = model.password, password.isEmpty {
            return "O campo de Senha é obrigatorio"
        }
        
        if let confirmation = model.passwordConfimation, confirmation.isEmpty {
            return "O campo de confirmaçao de senha é obrigatorio"
        }
        
        if model.password != model.passwordConfimation {
            return "Falha ao confirmar senha"
        }
        
        return nil
    }
}
