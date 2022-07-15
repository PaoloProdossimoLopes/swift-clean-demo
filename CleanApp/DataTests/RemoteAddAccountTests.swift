import XCTest
import Domain
@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let (sut, client) = makeSUT()
        
        sut.add(model: makeAddAccountModel())
        
        XCTAssertEqual(client.url, makeURL())
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, client) = makeSUT()
        let model = makeAddAccountModel()
        
        sut.add(model: model)
        
        XCTAssertEqual(client.data, model.asData)
    }
}

//MARK: - Helpers
private extension RemoteAddAccountTests {
    
    func makeSUT() -> (sut: RemoteAddAccount, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let url = makeURL()
        let sut = RemoteAddAccount(to: url, client: client)
        return (sut, client)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return .init(
            name: "any_name", email: "any_email@mail.com",
            password: "any_password", passwordConfirmation: "any_password"
        )
    }
    
    func makeURL() -> URL {
        URL(string: "http://any-url.com")!
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
        client.post(to: url, with: model.asData)
    }
}
