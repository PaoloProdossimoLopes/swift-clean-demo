import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let addAccount: AddAccount
    private let eValidator: EmailValidator
    private let loadingView: LoadingView
    
    public init(
        alertView: AlertView, eValidator: EmailValidator,
        addAccount: AddAccount, loadingView: LoadingView
    ) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.eValidator = eValidator
        self.loadingView = loadingView
    }
    
    public func signUp(model: SignUpModel) {
        if let message = validate(model: model) {
            showValidatedAlert(with: message)
            return
        }
        
        let account = SignUpMapper.toAddAccountModel(model)
        callAddAccount(with: account)
    }
    
    //MARK: - Helpers
    private func callAddAccount(with account: AddAccountModel) {
        loadingView.display(isLoading: true)
        addAccount.add(model: account) { [weak self] result in
            guard let self = self else { return }
            
            self.onAddResultHandler(result)
            self.loadingView.display(isLoading: false)
        }
    }
    
    private func onAddResultHandler(_ result: Result<AccountModel, DomainError>) {
        switch result {
        case .success:
            self.showSuccessAlert()
            
        case .failure:
            self.showFailureAlert()
        }
    }
    
    private func showValidatedAlert(with message: String) {
        let alertModel = AlertModel(title: "Falha na validaçao", message: message)
        alertView.showMessage(model: alertModel)
    }
    
    private func showSuccessAlert() {
        let alertModel = AlertModel(
            title: "Sucesso",
            message: "Conta criada com sucesso"
        )
        self.alertView.showMessage(model: alertModel)
    }
    
    private func showFailureAlert() {
        let alertModel = AlertModel(
            title: "Error",
            message: "Algo Inesperado aconteceu, tente novamente em alguns instantes"
        )
        self.alertView.showMessage(model: alertModel)
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


public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
