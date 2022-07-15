import Foundation

public typealias AddCompletionBlock = ((Result<AccountModel, Error>) -> Void)

public protocol AddAccount {
    func add(model: AddAccountModel, _ completion: @escaping AddCompletionBlock)
}
