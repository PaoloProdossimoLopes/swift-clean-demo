import Foundation

public struct SignUpModel: Equatable {
    public var name: String?
    public var emaail: String?
    public var password: String?
    public var passwordConfimation: String?
    
    public init(
        name: String?,
        emaail: String?,
        password: String?,
        passwordConfimation: String?
    ) {
        self.name = name
        self.emaail = emaail
        self.password = password
        self.passwordConfimation = passwordConfimation
    }
}
