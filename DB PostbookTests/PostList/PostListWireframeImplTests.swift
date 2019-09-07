import XCTest
@testable import DB_Postbook

class PostListWireframeImplTests: XCTestCase {

    var viewController: ViewControllerMock!
    var navigationController: UINavigationController!

    var sut: PostListWireframeImpl!

    override func setUp() {
        viewController = ViewControllerMock()
        navigationController = UINavigationController()

        sut = PostListWireframeImpl(navigationController: navigationController)
    }

    func testShowPostListWrapsPostListViewControllerInNavigationController() {
        sut.showPostList(on: viewController)

        XCTAssertNotNil(navigationController.topViewController as? PostListViewController)
    }

    func testShowPostListShowsNavigationControllerOnCorrectViewController() {
        sut.showPostList(on: viewController)

        XCTAssertEqual(viewController.showedViewController, navigationController)
    }

    class ViewControllerMock: UIViewController {
        var showedViewController: UIViewController?

        override func show(_ vc: UIViewController, sender: Any?) {
            self.showedViewController = vc
        }
    }
}


