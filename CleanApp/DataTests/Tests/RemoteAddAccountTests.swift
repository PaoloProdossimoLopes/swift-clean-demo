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
        
        expect(sut, completeWith: .failure(.unxpected), when: {
            client.completeWith(result: .failure(.noConnectivity))
        })
    }
    
    func test_add_should_complete_with_account_if_client_succeeds_complete_with_data() {
        let (sut, client) = makeSUT()
        let expected = makeAccountModel()
        
        expect(sut, completeWith: .success(expected)) {
            client.completeWith(result: .success(expected.asData))
        }
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_invalid_data() {
        let (sut, client) = makeSUT()
        
        expect(sut, completeWith: .failure(.unxpected)) {
            client.completeWith(result: .success(makeInvalidData()))
        }
    }
    
    func test_self_retain_memory_when_add_execute() {
        let (sut, client) = makeSUT()
        
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: client)
        
        sut.add(model: makeAddAccountModel()) { _ in }
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpSpy = HTTPClientSpy()
        var sut: RemoteAddAccount? = .init(to: makeURL(), client: httpSpy)
        var result: Result<AccountModel, DomainError>?
        
        sut?.add(model: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpSpy.completeWith(result: .failure(.noConnectivity))
        
        XCTAssertNil(result)
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
    
    func expect(
        _ sut: RemoteAddAccount,
        completeWith expectedResult: Result<AccountModel, DomainError>,
        when action: (() -> Void)
    ) {
        
        let exp = expectation(description: "waiting")
        sut.add(model: makeAddAccountModel()) { result in
            switch (expectedResult, result) {
            case (.failure(let expError), .failure(let reError)):
                XCTAssertEqual(expError, reError)
                
            case (.success(let expAccount), .success(let reAccount)):
                XCTAssertEqual(expAccount, reAccount)
                
            default:
                XCTFail("Expected \(expectedResult), but recieved \(result)")
            }
            
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return .init(
            name: "any_name", email: "any_email@mail.com",
            password: "any_password", passwordConfirmation: "any_password"
        )
    }
}
