import Foundation

public protocol AlertView: AnyObject {
    func showMessage(model: AlertModel)
}
