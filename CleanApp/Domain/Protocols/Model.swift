import Foundation

public protocol Model: Encodable { }

public extension Model {
    var asData: Data? { try? JSONEncoder().encode(self) }
}
