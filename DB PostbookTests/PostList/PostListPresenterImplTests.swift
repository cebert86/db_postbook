import XCTest
@testable import DB_Postbook

class PostListPresenterImplTests: XCTestCase {

    var postFetcher: PostFetcherMock!
    var postListViewController: PostListViewControllerMock!

    var sut: PostListPresenterImpl!

    override func setUp() {
        postFetcher = PostFetcherMock()
        postListViewController = PostListViewControllerMock()

        sut = PostListPresenterImpl(postFetcher: postFetcher)
    }

    func testViewDidLoadFetchesPostsForUserId() {
        sut.viewDidLoad()

        XCTAssertTrue(postFetcher.fetchCalled)
    }

    func testViewDidLoadReloadsTableView() {
        sut.view = postListViewController

        sut.viewDidLoad()

        XCTAssertTrue(postListViewController.reloadTableViewCalled)
    }

    func testTableViewDataSourceReturnsNumberOfRows() {
        sut.view = postListViewController

        sut.viewDidLoad()

        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 2)
    }

    func testTableViewDataSourceReturnsPostTableViewCell() {
        sut.view = postListViewController
        sut.viewDidLoad()

        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reuseIdentifer")

        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(cell as? PostTableViewCell)
        XCTAssertEqual((cell.subviews[1] as? UIButton)?.title(for: .normal), "FAV")
        XCTAssertEqual((cell.subviews[2] as? UILabel)?.text, "some-title-1")
        XCTAssertEqual((cell.subviews[3] as? UILabel)?.text, "some-body-1")
    }

    class PostFetcherMock: PostFetcher {
        var fetchCalled = false

        func fetch(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
            fetchCalled = true
            onSuccess([Post(userId: 1, id: 1, title: "some-title-1", body: "some-body-1"),
                       Post(userId: 1, id: 2, title: "some-title-2", body: "some-body-2")])
        }
    }

    class PostListViewControllerMock: PostListViewController {
        var reloadTableViewCalled = false

        override func reloadTableView() {
            reloadTableViewCalled = true
        }
    }
}

