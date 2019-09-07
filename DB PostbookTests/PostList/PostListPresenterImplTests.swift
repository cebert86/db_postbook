import XCTest
@testable import DB_Postbook

class PostListPresenterImplTests: XCTestCase {

    var postFetcher: PostFetcherMock!
    var userManager: UserManagerMock!
    var postListViewController: PostListViewControllerMock!

    var sut: PostListPresenterImpl!

    override func setUp() {
        postFetcher = PostFetcherMock()
        userManager = UserManagerMock()
        postListViewController = PostListViewControllerMock()

        sut = PostListPresenterImpl(postFetcher: postFetcher, userManager: userManager)
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
        XCTAssertNotNil((cell as? PostTableViewCell)?.canAddFavouritePost)
        XCTAssertEqual((cell.subviews[1] as? UIButton)?.title(for: .normal), "FAV")
        XCTAssertEqual((cell.subviews[2] as? UILabel)?.text, "some-title-1")
        XCTAssertEqual((cell.subviews[3] as? UILabel)?.text, "some-body-1")
    }

    func testAddFavouritePost() {
        let post = Post(userId: 1, id: 1, title: "some-title", body: "some-body")

        sut.addFavouritePost(post)

        XCTAssertEqual(userManager.favouritePostToAdd, post)
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

    class UserManagerMock: UserManager {
        var favouritePostToAdd: Post?

        var currentUserId: Int {
            get {
                return 0
            }
            set {

            }
        }

        var favouritePosts: [Post] {
            get {
                return []
            }
            set {

            }
        }

        func addFavouritePost(_ post: Post) {
            favouritePostToAdd = post
        }
    }
}

