import Foundation

struct Enviroment {
    
    enum Key: String {
        case url = "API_BASE_URL"
    }
    
    static let shared: Enviroment = .init()
    
    private init() {  }
    
    func variable(_ key: Key) -> String {
        guard let dictValue = Bundle.main.infoDictionary?[key.rawValue] else {
            fatalError("Not found info plist")
        }
                
        guard let stringValue = dictValue as? String else {
            fatalError("value for \(key.rawValue) in info .plist not is a string")
        }
        
        return stringValue
    }
}
