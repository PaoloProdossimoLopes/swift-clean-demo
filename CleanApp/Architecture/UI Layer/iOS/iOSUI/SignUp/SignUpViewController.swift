import UIKit
import Presentation

public final class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    var signUp: ((SignUpModel) -> Void)?
    
    public init(signUp: ((SignUpModel) -> Void)?) {
        self.signUp = signUp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
        configureAction()
    }
    
    //MARK: - Helpers
    private func configureAction() {
        saveButton.addTarget(self, action: #selector(saveButtonHandleTapped), for: .touchUpInside)
        hideKeyboardOnTap()
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
    public func display(isLoading: Bool) {
        guard isLoading else {
            view.isUserInteractionEnabled = false
            loadingView.stopAnimating()
            return
        }
        
        view.isUserInteractionEnabled = true
        loadingView.startAnimating()
    }
}

//MARK: - AlertView
extension SignUpViewController: AlertView {
    public func showMessage(model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
