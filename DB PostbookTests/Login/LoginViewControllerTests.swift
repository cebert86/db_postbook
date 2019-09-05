import XCTest
@testable import DB_Postbook

class LoginViewControllerTests: XCTestCase {

    var presenter: LoginPresenterMock!

    var sut: LoginViewController!

    override func setUp() {
        presenter = LoginPresenterMock()
        
        sut = LoginViewController(presenter: presenter)

        sut.viewDidLoad()
    }

    func testInitSetsViewOnPresenter() {
        XCTAssertNotNil(presenter.view)
    }

    func testViewDidLoadSetsBackgroundColor() {
        XCTAssert(sut.view.backgroundColor == .white)
    }

    func testContainsUserIdTextField() {
        let userIdTextField = firstSubviewOfClass(UITextField.self, in: sut.view) as? UITextField

        XCTAssertNotNil(userIdTextField)
        XCTAssert(userIdTextField?.borderStyle == .roundedRect)
        XCTAssertEqual(userIdTextField?.placeholder, "User ID")
    }

    func testContainsLoginButton() {
        let loginButton = firstSubviewOfClass(UIButton.self, in: sut.view) as? UIButton

        XCTAssertNotNil(loginButton)
        XCTAssert(loginButton?.titleColor(for: .normal) == .blue)
        XCTAssertEqual(loginButton?.title(for: .normal), "Login")
    }

    func testLoginButtonTappedDelegatesToPresenterIfValidUserIdAvailable() {
        let userIdTextField = firstSubviewOfClass(UITextField.self, in: sut.view) as? UITextField
        userIdTextField?.text = "1"
        let loginButton = firstSubviewOfClass(UIButton.self, in: sut.view) as? UIButton

        loginButton?.sendActions(for: .touchUpInside)

        XCTAssert(presenter.userId == 1)
    }

    func testLoginButtonTappedDoesNotDelegateToPresenterIfNoValidUserIdAvailable() {
        let userIdTextField = firstSubviewOfClass(UITextField.self, in: sut.view) as? UITextField
        userIdTextField?.text = "some-invalid-user-id"
        let loginButton = firstSubviewOfClass(UIButton.self, in: sut.view) as? UIButton

        loginButton?.sendActions(for: .touchUpInside)

        XCTAssert(presenter.userId == 0)
    }

    private func firstSubviewOfClass<T>(_ classType: T.Type, in superview: UIView) -> UIView? {
        return superview.subviews.first { classType == type(of: $0) }
    }

    class LoginPresenterMock: LoginPresenter {
        var _view: LoginViewController?
        var view: LoginViewController? {
            get {
                return _view
            }
            set {
                _view = newValue
            }
        }
        
        var userId = 0

        func loginButtonTapped(userId: Int) {
            self.userId = userId
        }
    }
}
