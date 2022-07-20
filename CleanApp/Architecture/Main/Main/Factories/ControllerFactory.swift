import Foundation
import iOSUI
import Presentation
import Validation
import Data
import Infra
import Domain

final class ControllerFactory {
    static func makeController(addAccount: AddAccount) -> SignUpViewController {
        let controller: SignUpViewController = .init()
        let eValdatorAdapter = EmailValidatorAdapter.shared
        //let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        //let url = URL(string: "https://asdasdasdaasd.asdasd.com")!
        //let client = AlamofireAdapter()
        //let account = RemoteAddAccount(to: url, client: client)
        let presenter = SignUpPresenter(
            alertView: controller, eValidator: eValdatorAdapter,
            addAccount: addAccount, loadingView: controller
        )
        controller.signUp = presenter.signUp
        return controller
    }
    
}
