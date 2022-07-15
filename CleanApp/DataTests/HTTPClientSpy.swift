import Foundation
import Data

final class HTTPClientSpy: HTTPPostClient {
    
    var url: URL?
    var data: Data?
    private(set) var callCount: Int = .zero
    
    func post(to url: URL, with data: Data?) {
        self.url = url
        self.data = data
        callCount += 1
    }
}
