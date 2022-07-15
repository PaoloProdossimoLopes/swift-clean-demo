import XCTest
import Domain

@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let (sut, client) = makeSUT()
        
        sut.add(model: makeAddAccountModel()) { _ in }
        
        XCTAssertEqual(client.url, makeURL())
    }
    
    func test_add_should_call_httpClient_with_only_one_call() {
        let (sut, client) = makeSUT()
        
        sut.add(model: makeAddAccountModel()) { _ in }
        
        XCTAssertEqual(client.callCount, 1)
    }
    
    func test_add_should_call_httpClient_with_two_calls_detected() {
        let (sut, client) = makeSUT()
        
        sut.add(model: makeAddAccountModel()) { _ in }
        sut.add(model: makeAddAccountModel()) { _ in }
        
        XCTAssertEqual(client.callCount, 2)
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, client) = makeSUT()
        let model = makeAddAccountModel()
        
        sut.add(model: model) { _ in }
        
        XCTAssertEqual(client.data, model.asData)
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_error() {
        let (sut, client) = makeSUT()
        let expectation = expectation(description: "waiting")
        
        sut.add(model: makeAddAccountModel()) { result in
            
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unxpected)
            case .success:
                XCTFail("Epected error, recieved \(result) instead")
            }
            
            expectation.fulfill()
        }
        
        client.completeWith(error: .noConnectivity)
        
        wait(for: [expectation], timeout: 1)
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
