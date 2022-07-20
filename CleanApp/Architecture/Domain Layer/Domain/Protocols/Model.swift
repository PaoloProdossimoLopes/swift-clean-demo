import Foundation

public protocol Model: Codable, Equatable { }

public extension Model {
    var asData: Data? { try? JSONEncoder().encode(self) }
    
    var asJSON: [String: Any]? {
        guard let data = self.asData else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

public extension Data {
    func asModel<T: Decodable>(from data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
