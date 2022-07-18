import UIKit

extension UIControl {
    ///For this execute correct the selector method does not be able paramether in @objc method passed in selector
    func simulate(_ event: Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?
                .forEach { action in
                    (target as NSObject).perform(Selector(action))
                }
        }
    }
    
    func simulateTap() { simulate(.touchUpInside) }
}
