import Foundation
import Domain

final class SignUpPresenter {
    
    private let alertView: AlertView
    private let addAccount: AddAccount
    private let eValidator: EmailValidator
    private let loadingView: LoadingView
    
    init(
        alertView: AlertView, eValidator: EmailValidator,
        addAccount: AddAccount, loadingView: LoadingView
    ) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.eValidator = eValidator
        self.loadingView = loadingView
    }
    
    func signUp(model: SignUpModel) {
        if let message = validate(model: model) {
            let alertModel = AlertModel(title: "Falha na validaçao", message: message)
            alertView.showMessage(model: alertModel)
            return
        }
        
        let account = AddAccountModel(
            name: model.name!, email: model.emaail!,
            password: model.password!, passwordConfirmation: model.passwordConfimation!
        )
        
        loadingView.display(isLoading: true)
        addAccount.add(model: account) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let _):
                break
            case .failure:
                let alertModel = AlertModel(
                    title: "Error",
                    message: "Algo Inesperado aconteceu, tente novamente em alguns instantes"
                )
                
                self.loadingView.display(isLoading: false)
                self.alertView.showMessage(model: alertModel)
            }
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
