import XCTest
@testable import DB_Postbook

class CommentListWireframeImplTests: XCTestCase {

    var viewController: ViewControllerMock!
    var navigationController: UINavigationController!

    var sut: CommentListWireframeImpl!

    override func setUp() {
        viewController = ViewControllerMock()
        navigationController = UINavigationController()

        sut = CommentListWireframeImpl()
    }

    func testShowCommentsPutsCommentListViewControllerAsTopViewController() {
        sut.showComments(on: navigationController, for: Post(userId: 1, id: 1, title: "some-title", body: "some-body"))

        XCTAssertNotNil(navigationController.topViewController as? CommentListViewController)
    }

    class ViewControllerMock: UIViewController {
        var showedViewController: UIViewController?

        override func show(_ vc: UIViewController, sender: Any?) {
            self.showedViewController = vc
        }
    }
}


