import Foundation

public struct AlertModel: Equatable {
    public var title: String
    public var message: String
    
    public init(
        title: String,
        message: String
    ) {
        self.title = title
        self.message = message
    }
}
