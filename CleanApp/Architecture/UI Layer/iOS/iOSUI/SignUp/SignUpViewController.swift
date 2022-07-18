import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    var signUp: ((SignUpModel) -> Void)?
    
    //MARK: - UI Components
    let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordConfimationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "confirmation"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //MARK: - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
        configureAction()
    }
    
    //MARK: - Helpers
    private func configureAction() {
        saveButton.addTarget(self, action: #selector(saveButtonHandleTapped), for: .touchUpInside)
    }
    
    //MARK: - Selectos
    @objc private func saveButtonHandleTapped() {
        let signUpModel = SignUpModel.init(
            name: nameTextField.text, emaail: emailTextField.text,
            password: passwordTextField.text, passwordConfimation: passwordConfimationTextField.text
        )
        signUp?(signUpModel)
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
