import XCTest

final class SignUpViewControllerTests: XCTestCase {
    
    func test_loading_is_hidden_on_start() {
        let sut = SignUpViewController()
        _ = sut.view
        XCTAssertFalse(sut.loadingView.isAnimating)
    }
}







protocol ViewCodeProtocol {
    func configureViewCode()
    func configureHierarchy()
    func configureConstraint()
    func configureStyle()
}

extension ViewCodeProtocol {
    func configureViewCode() {
        configureHierarchy()
        configureConstraint()
        configureStyle()
    }
    
    func configureStyle() {}
}


import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }
}

//MARK: - ViewCodeProtocol
extension SignUpViewController: ViewCodeProtocol {
    
    func configureHierarchy() {
        view.addSubview(loadingView)
    }
    
    func configureConstraint() {
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func configureStyle() {
        view.backgroundColor = .darkGray
    }
}

//MARK: - LoadingView
extension SignUpViewController: LoadingView {
    func display(isLoading: Bool) {
        guard isLoading else {
            loadingView.stopAnimating()
            return
        }
        
        loadingView.startAnimating()
    }
}
