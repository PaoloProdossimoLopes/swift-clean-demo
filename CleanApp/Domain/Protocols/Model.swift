import Foundation

public protocol Model: Codable, Equatable { }

public extension Model {
    var asData: Data? { try? JSONEncoder().encode(self) }
    
}

public extension Data {
    func asModel<T: Decodable>(from data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
