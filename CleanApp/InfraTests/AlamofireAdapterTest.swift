import XCTest
import Alamofire
import Data

final class AlamofireAdapterTest: XCTestCase {
    
    private var sut: AlamofireAdapter!
    private var session: Session!
    private var configuration: URLSessionConfiguration!
    
    override func setUp() {
        makeSUT()
    }
    
    func test_post_should_make_request_with_valid_url() {
        let url = makeURL()
        sut.post(to: url, with: makeInvalidData())
        expect { XCTAssertEqual(url, $0.url) }
    }
    
    func test_post_should_make_request_with_correct_http_method() {
        sut.post(to: makeURL(), with: makeInvalidData())
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
    
    func test_sut_was_retain_memory_when_should_be_deallocated() {
        let iConfiguration = makeURLConfig()
        let iSession = Session(configuration: iConfiguration)
        let iSut = AlamofireAdapter(session: iSession)
        checkMemoryLeak(for: iSut)
        sut.post(to: makeURL(), with: makeInvalidData())
    }
    
    func test_post_should_complete_with_error_request_completes_with_error() {
        URLProtocolStub.simulate(data: nil, response: nil, error: makeError())
        expectResult(.failure(.noConnectivity))
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
    
    func expectResult(
        _ expected: Result<Data, HTTPError>,
        file: StaticString = #file, line: UInt = #line
    ) {
        let exp = expectation(description: "wait")
        
        sut.post(to: makeURL(), with: makeValidData()) { result in
            switch (expected, result) {
            case (.failure(let eError), .failure(let rError)):
                XCTAssertEqual(eError, rError, file: file, line: line)
                
            case (.success(let eData), .success(let rData)):
                XCTAssertEqual(eData, rData, file: file, line: line)
                
            default:
                XCTFail("PROBLEM: Expected: \(expected), but recieved \(result) instead.",
                        file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    @discardableResult func makeSUT() -> AlamofireAdapter {
        configuration = makeURLConfig()
        session = Session(configuration: configuration)
        sut = AlamofireAdapter(session: session)
        let SUT = sut
        return SUT!
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
    
    func post(
        to url: URL,
        with data: Data? = nil,
        _ completion: ((Result<Data, HTTPError>) -> Void)? = nil
    ) {
        session
            .request(
                url,
                method: .post,
                parameters: handleDataToJson(data),
                encoding: JSONEncoding.default
            )
            .responseData { dataResponse in
                switch dataResponse.result {
                case .failure:
                    completion?(.failure(.noConnectivity))
                case .success:
                    break
                }
            }
    }
    
    private func handleDataToJson(_ data: Data?) -> [String: Any]? {
        guard let  data = data else { return nil }
        let jsonSerialized = try? JSONSerialization
            .jsonObject(with: data, options: .fragmentsAllowed)
        let json = jsonSerialized as? [String: Any]
        return json
    }
}







final class URLProtocolStub: URLProtocol {
    
    static var data: Data?
    static var error: Error?
    static var response: HTTPURLResponse?
    
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
        verifyClientHandlers()
    }
    
    override func stopLoading() {
        /*Non nescessary*/
    }
    
    //MARK: - Methods
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        URLProtocolStub.data = data
        URLProtocolStub.response = response
        URLProtocolStub.error = error
    }
    
    //MARK: - Helpers
    
    private func verifyClientHandlers() {
        configureData()
        configureResponse()
        configureError()
        
        client?.urlProtocolDidFinishLoading(self)//Notify that request was handleded and to be done
    }
    
    private func configureData() {
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
    }
    
    private func configureResponse() {
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
    }
    
    private func configureError() {
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}

