import Foundation
import Domain

public final class RemoteAddAccount {
    
    private let url: URL
    private let client: HTTPPostClient
    
    public init(to url: URL, client: HTTPPostClient) {
        self.url = url
        self.client = client
    }
    
    public func add(model: AddAccountModel, completion: @escaping ((Result<AccountModel,DomainError>) -> Void)) {
        
        client.post(to: url, with: model.asData) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.handleSuccess(data, completion: completion)
                
            case .failure:
                completion(.failure(.unxpected))
            }
        }
    }
    
    private func handleSuccess(_ data: Data?, completion: ((Result<AccountModel,DomainError>) -> Void)) {
        guard let data = data, let model: AccountModel = data.asModel(from: data) else {
            completion(.failure(.unxpected))
            return
        }
        
        completion(.success(model))
    }
}
