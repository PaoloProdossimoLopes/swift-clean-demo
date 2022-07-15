import Foundation

public protocol HTTPPostClient {
    func post(to url: URL, with data: Data?, _ completion: @escaping (HTTPError) -> Void)
}
