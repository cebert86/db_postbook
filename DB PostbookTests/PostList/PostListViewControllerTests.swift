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

    func testContainsSegmentedControl() {
        let segmentedControl = firstSubviewOfClass(UISegmentedControl.self, in: sut.view) as? UISegmentedControl

        XCTAssertNotNil(segmentedControl)
        XCTAssert(segmentedControl?.selectedSegmentIndex == 0)
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

    class PostListPresenterMock: NSObject, PostListPresenter, UITableViewDataSource {
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

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
}
