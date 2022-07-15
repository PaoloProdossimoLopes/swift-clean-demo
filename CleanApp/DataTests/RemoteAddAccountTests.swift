import XCTest
import Domain
@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let client = HTTPClientSpy()
        let url = URL(string: "http://any-url.com")!
        let sut = RemoteAddAccount(to: url, client: client)
        let addModel = AddAccountModel.init(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        
        sut.add(model: addModel)
        
        XCTAssertEqual(client.url, url)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let client = HTTPClientSpy()
        let sut = RemoteAddAccount(to: URL(string: "http://any-url.com")!, client: client)
        let addModel = AddAccountModel.init(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        
        sut.add(model: addModel)
        
        let data = try? JSONEncoder().encode(addModel)
        XCTAssertEqual(client.data, data)
    }
}
















final class HTTPClientSpy: HTTPPostClient {
    
    var url: URL?
    var data: Data?
    
    func post(to url: URL, with data: Data?) {
        self.url = url
        self.data = data
    }
}





protocol HTTPPostClient {
    func post(to url: URL, with data: Data?)
}

final class RemoteAddAccount {
    
    private let url: URL
    private let client: HTTPPostClient
    
    init(to url: URL, client: HTTPPostClient) {
        self.url = url
        self.client = client
    }
    
    func add(model: AddAccountModel) {
        let data = try? JSONEncoder().encode(model)
        client.post(to: url, with: data)
    }
}
