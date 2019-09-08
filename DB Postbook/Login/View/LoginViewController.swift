import SnapKit
import UIKit

class LoginViewController: UIViewController {

    private var presenter: LoginPresenter

    private let userIdTextField = UITextField()
    private let loginButton = UIButton(type: .roundedRect)

    init(presenter: LoginPresenter = LoginPresenterImpl()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        defer {
            self.presenter.view = self
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Do not call from storyboard!")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        configureUserIdTextField()
        configureLoginButton()
    }

    private func configureUserIdTextField() {
        userIdTextField.borderStyle = .roundedRect
        userIdTextField.placeholder = "User ID"

        view.addSubview(userIdTextField)
        userIdTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func configureLoginButton() {
        loginButton.setTitle("Login", for: .normal)

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(userIdTextField.snp.bottom).offset(15)
            make.centerX.equalTo(userIdTextField)
        }

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc
    private func loginButtonTapped() {
        guard let text = userIdTextField.text, let userId = Int(text) else {
            return
        }

        presenter.loginButtonTapped(userId: userId)
    }
}
