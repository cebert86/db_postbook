import XCTest
@testable import DB_Postbook

class LoginPresenterImplTests: XCTestCase {

    var userDefaults: UserDefaults!
    var wireframe: PostListWireframeMock!
    var userManager: UserManager!
    var viewController: LoginViewController!

    var sut: LoginPresenterImpl!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: "TestUserDefaults")
        wireframe = PostListWireframeMock()
        userManager = UserManagerImpl(userDefaults: userDefaults)
        viewController = LoginViewController()

        sut = LoginPresenterImpl(postListWireframe: wireframe, userManager: userManager)

        userDefaults.removePersistentDomain(forName: "TestUserDefaults")
        userDefaults.synchronize()
    }

    func testLoginButtonTappedDoesNotShowPostListIfNoViewIsAvailable() {
        sut.loginButtonTapped(userId: 1)

        XCTAssertFalse(wireframe.showPostListCalled)
    }

    func testLoginButtonDoesNotSaveCurrentUserIdIfNoViewIsAvailable() {
        sut.loginButtonTapped(userId: 1)

        XCTAssert(userManager.currentUserId == 0)
    }

    func testLoginButtonTappedShowsPostListIfViewIsAvailable() {
        sut.view = viewController

        sut.loginButtonTapped(userId: 1)

        XCTAssertTrue(wireframe.showPostListCalled)
    }

    func testLoginButtonSavesCurrentUserIdIfViewIsAvailable() {
        sut.view = viewController

        sut.loginButtonTapped(userId: 1)

        XCTAssert(userManager.currentUserId == 1)
    }

    class PostListWireframeMock: PostListWireframe {
        var showPostListCalled = false

        func showPostList(on viewController: UIViewController) {
            showPostListCalled = true
        }
    }
}

