import Foundation
import Domain

public final class RemoteAddAccount {
    
    private let url: URL
    private let client: HTTPPostClient
    
    public init(to url: URL, client: HTTPPostClient) {
        self.url = url
        self.client = client
    }
    
    public func add(model: AddAccountModel) {
        client.post(to: url, with: model.asData)
    }
}