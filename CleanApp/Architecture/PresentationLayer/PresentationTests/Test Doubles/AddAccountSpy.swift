import Domain

final class AddAccountSpy: AddAccount {
    
    var model: AddAccountModel?
    var expected: AddCompletionBlock?
    
    func add(model: AddAccountModel, _ completion: @escaping AddCompletionBlock) {
        self.model = model
        expected = completion
    }
    
    func completeWith(_ error: DomainError) {
        expected?(.failure(error))
    }
    
    func completeWith(_ succes: AccountModel) {
        expected?(.success(succes))
    }
}
