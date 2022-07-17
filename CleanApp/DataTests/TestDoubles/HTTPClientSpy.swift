import Foundation //Standard
import Data //Personal

final class HTTPClientSpy: HTTPPostClient {
    
    var url: URL?
    var data: Data?
    
    private var completionHandler: ((Result<Data?, HTTPError>) -> Void)?
    private(set) var callCount: Int = .zero
    
    func post(to url: URL, with data: Data?, _ completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        self.url = url
        self.data = data
        callCount += 1
        completionHandler = completion
    }
    
    func completeWith(result: (Result<Data?, HTTPError>)) {
        completionHandler?(result)
    }
}
