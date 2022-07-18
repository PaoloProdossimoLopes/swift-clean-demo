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

//MARK: - AlertView
extension SignUpViewController: AlertView {
    func showMessage(model: AlertModel) {
        
    }
}
