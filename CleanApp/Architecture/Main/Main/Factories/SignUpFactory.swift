import Foundation
import iOSUI
import Presentation
import Validation
import Data
import Infra

final class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller: SignUpViewController = .init()
        let eValdatorAdapter = EmailValidatorAdapter.shared
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let client = AlamofireAdapter()
        let account = RemoteAddAccount(to: url, client: client)
        let presenter = SignUpPresenter(
            alertView: controller, eValidator: eValdatorAdapter,
            addAccount: account, loadingView: controller
        )
        controller.signUp = presenter.signUp
        return controller
    }
}
