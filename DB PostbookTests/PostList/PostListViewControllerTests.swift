import XCTest
@testable import DB_Postbook

class PostListViewControllerTests: XCTestCase {

    var presenter: PostListPresenterMock!

    var sut: PostListViewController!

    override func setUp() {
        presenter = PostListPresenterMock()

        sut = PostListViewController(presenter: presenter)

        sut.viewDidLoad()
    }

    func testInitSetsViewOnPresenter() {
        XCTAssertNotNil(presenter.view)
    }

    func testViewDidLoadSetsBackgroundColor() {
        XCTAssert(sut.view.backgroundColor == .white)
    }

    func testViewDidLoadDelegatesToPresenter() {
        sut.viewDidLoad()

        XCTAssertTrue(presenter.viewDidLoadCalled)
    }

    class PostListPresenterMock: PostListPresenter {
        var _view: PostListViewController?
        var view: PostListViewController? {
            get {
                return _view
            }
            set {
                _view = newValue
            }
        }

        var viewDidLoadCalled = false

        func viewDidLoad() {
            viewDidLoadCalled = true
        }
    }
}
