import XCTest
import Alamofire

final class AlamofireAdapterTest: XCTestCase {
    
    private var sut: AlamofireAdapter!
    private var session: Session!
    private var configuration: URLSessionConfiguration!
    
    override func setUp() {
        makeSUT()
    }
    
    func test_post_should_make_request_with_valid_url() {
        let url = makeURL()
        sut.post(to: url)
        expect { XCTAssertEqual(url, $0.url) }
    }
    
    func test_post_should_make_request_with_correct_http_method() {
        sut.post(to: makeURL())
        expect { XCTAssertEqual("POST", $0.httpMethod) }
    }
    
    func test_post_should_make_request_with_not_nil_httpBodyStream_when_data_is_valid() {
        sut.post(to: makeURL(), with: makeValidData())
        expect { XCTAssertNotNil($0.httpBodyStream) }
    }
    
    func test_post_should_make_request_with_nil_httpBodyStream_when_data_is_invalid() {
        sut.post(to: makeURL(), with: makeInvalidData())
        expect { XCTAssertNil($0.httpBodyStream) }
    }
}

//MARK: - Helpers
private extension AlamofireAdapterTest {
    
    func expect(_ completion: @escaping ((URLRequest) -> Void)) {
        let exp = expectation(description: "waiting")
        
        URLProtocolStub.observerRequest { request in
            completion(request)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
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
    
    func post(to url: URL, with data: Data? = nil) {
        guard let data = data else { return }
        
        let jsonSerialized = try? JSONSerialization
            .jsonObject(with: data, options: .fragmentsAllowed)
        let json = jsonSerialized as? [String: Any]
        
        let request = session
            .request(url, method: .post, parameters: json, encoding: JSONEncoding.default)
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

