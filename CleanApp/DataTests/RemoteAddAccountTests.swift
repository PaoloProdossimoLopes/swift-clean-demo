import XCTest
@testable import Data

final class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpClient_with_correct_url() {
        let client = HTTPClientSpy()
        let url = URL(string: "http://any-url.com")!
        let sut = RemoteAddAccount(url: url, client: client)
        
        sut.add()
        
        XCTAssertEqual(client.url, url)
    }
}
















final class HTTPClientSpy: HTTPPostClient {
    
    var url: URL?
    
    func post(url: URL) {
        self.url = url
    }
}

protocol HTTPPostClient {
    func post(url: URL)
}

final class RemoteAddAccount {
    
    private let url: URL
    private let client: HTTPPostClient
    
    init(url: URL, client: HTTPPostClient) {
        self.url = url
        self.client = client
    }
    
    func add() {
        client.post(url: url)
    }
    
}
