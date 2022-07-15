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
















