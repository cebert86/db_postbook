import XCTest
@testable import DB_Postbook

class CommentListViewControllerTests: XCTestCase {

    var presenter: CommentListPresenterMock!

    var sut: CommentListViewController!

    override func setUp() {
        presenter = CommentListPresenterMock()

        sut = CommentListViewController(presenter: presenter)

        sut.viewDidLoad()
    }

    func testInitSetsViewOnPresenter() {
        XCTAssertNotNil(presenter.view)
    }

    func testViewDidLoadSetsTitle() {
        XCTAssertEqual(sut.title, "Kommentare")
    }

    func testViewDidLoadSetsBackgroundColor() {
        XCTAssert(sut.view.backgroundColor == .white)
    }

    func testViewDidLoadDelegatesToPresenter() {
        sut.viewDidLoad()

        XCTAssertTrue(presenter.viewDidLoadCalled)
    }

    func testContainsTableView() {
        let tableView = firstSubviewOfClass(UITableView.self, in: sut.view) as? UITableView

        XCTAssertNotNil(tableView)
    }

    func testSetsTableViewsDataSource() {
        let tableView = firstSubviewOfClass(UITableView.self, in: sut.view) as? UITableView

        XCTAssertNotNil(tableView?.dataSource)
    }

    private func firstSubviewOfClass<T>(_ classType: T.Type, in superview: UIView) -> UIView? {
        return superview.subviews.first { classType == type(of: $0) }
    }

    class CommentListPresenterMock: NSObject, CommentListPresenter, UITableViewDataSource {
        var _view: CommentListViewController?
        var view: CommentListViewController? {
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

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
}
