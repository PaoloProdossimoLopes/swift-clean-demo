import Foundation

public enum HTTPError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case anauthorized
    case forbidden
}
