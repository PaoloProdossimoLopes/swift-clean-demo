import Foundation

public typealias AddCompletionBlock = ((Result<AccountModel, DomainError>) -> Void)

public protocol AddAccount {
    func add(model: AddAccountModel, _ completion: @escaping AddCompletionBlock)
}
