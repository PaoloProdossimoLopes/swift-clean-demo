import Domain
import iOSUI

public final class SignUpComposer {
    
    static func composeController(with addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeController(addAccount: addAccount)
    }
}
