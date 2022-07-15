import Foundation
import Data

final class HTTPClientSpy: HTTPPostClient {
    
    var url: URL?
    var data: Data?
    private var completionHandler: ((HTTPError) -> Void)?
    private(set) var callCount: Int = .zero
    
    func post(to url: URL, with data: Data?, _ completion: @escaping (HTTPError) -> Void) {
        self.url = url
        self.data = data
        callCount += 1
        completionHandler = completion
    }
    
    func completeWith(error: HTTPError) {
        completionHandler?(error)
    }
}
