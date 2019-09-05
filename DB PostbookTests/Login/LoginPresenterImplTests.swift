import XCTest
@testable import DB_Postbook

class LoginPresenterImplTests: XCTestCase {

    var wireframe: PostListWireframeMock!
    var viewController: LoginViewController!

    var sut: LoginPresenterImpl!

    override func setUp() {
        wireframe = PostListWireframeMock()
        viewController = LoginViewController()

        sut = LoginPresenterImpl(postListWireframe: wireframe)
    }

    func testLoginButtonTappedDoesNotShowPostListIfNoViewIsAvailable() {
        sut.loginButtonTapped(userId: 1)

        XCTAssert(wireframe.userId == 0)
    }

    func testLoginButtonTappedShowsPostListIfViewIsAvailable() {
        sut.view = viewController

        sut.loginButtonTapped(userId: 1)

        XCTAssert(wireframe.userId == 1)
    }

    class PostListWireframeMock: PostListWireframe {
        var userId = 0

        func showPostList(for userId: Int, on viewController: UIViewController) {
            self.userId = userId
        }
    }
}

