import Foundation

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
        clean()
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
    
    private func clean() {
        URLProtocolStub.data = nil
        URLProtocolStub.error = nil
        URLProtocolStub.response = nil
    }
}
