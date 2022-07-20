import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    
    private static let client = AlamofireAdapter()
    private static let rootURL =  "https://asdasdasdaasd.asdasd.com/api"
    
    private static func makeURL(with path: String) -> URL {
        return URL(string: "\(rootURL)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        return RemoteAddAccount(to: makeURL(with: "singup"), client: client)
    }
}
