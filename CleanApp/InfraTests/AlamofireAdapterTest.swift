import XCTest
import Alamofire

final class AlamofireAdapterTest: XCTestCase {
    
    private var sut: AlamofireAdapter!
    private var session: Session!
    private var configuration: URLSessionConfiguration!
    
    func test_() {
        makeSUT()
        let url = makeURL()
        
        sut.post(to: url)
        
        let exp = expectation(description: "waiting")
        URLProtocolStub.observerRequest { request in
            XCTAssertEqual(url, request.url)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
}

//MARK: - Helpers
private extension AlamofireAdapterTest {
    
    func makeSUT() {
        configuration = makeURLConfig()
        session = Session(configuration: configuration)
        sut = AlamofireAdapter(session: session)
    }
    
    func makeURLConfig() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        return configuration
    }
}





final class AlamofireAdapter {
    
    private var session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        let request = session.request(url)
        request.resume()
    }
}







final class URLProtocolStub: URLProtocol {
    
    //MARK: - Observer pattern
    private static var emit: ((URLRequest) -> Void)?
    
    static func observerRequest(_ completion: @escaping ((URLRequest) -> Void)) {
        URLProtocolStub.emit = completion
    }
    
    //MARK: - URLProtocol
    override class func canInit(with request: URLRequest) -> Bool {
        return true //True indica que quer interceptar TODOS os requets
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        URLProtocolStub.emit?(request)
    }
    
    override func stopLoading() {
        /*Non nescessary*/
    }
}
