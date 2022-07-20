import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    static func makeRemoteAddAccount() -> AddAccount {
        let client = AlamofireAdapter()
        let url = URL(string: "https://asdasdasdaasd.asdasd.com")!
        return RemoteAddAccount(to: url, client: client)
    }
}
