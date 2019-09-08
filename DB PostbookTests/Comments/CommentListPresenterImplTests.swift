import XCTest
@testable import DB_Postbook

class CommentListPresenterImplTests: XCTestCase {

    var postFetcher: PostFetcherMock!
    var userManager: UserManagerMock!
    var commentListViewController: CommentListViewControllerMock!

    var sut: CommentListPresenterImpl!

    override func setUp() {
        postFetcher = PostFetcherMock()
        userManager = UserManagerMock()
        let post = Post(userId: 1, id: 1, title: "some-title", body: "some-body")
        commentListViewController = CommentListViewControllerMock(presenter: CommentListPresenterImpl(post: post))

        sut = CommentListPresenterImpl(post: post, postFetcher: postFetcher, userManager: userManager)
    }

    func testViewDidLoadFetchesCommentsForPostId() {
        sut.viewDidLoad()

        XCTAssertTrue(postFetcher.commentsCalled)
    }

    func testViewDidLoadReloadsTableView() {
        sut.view = commentListViewController

        sut.viewDidLoad()

        XCTAssertTrue(commentListViewController.reloadTableViewCalled)
    }

    func testTableViewDataSourceReturnsNumberOfSections() {
        sut.view = commentListViewController

        sut.viewDidLoad()

        XCTAssert(sut.numberOfSections(in: UITableView()) == 2)
    }

    func testTableViewDataSourceReturnsNumberOfRows() {
        sut.view = commentListViewController

        sut.viewDidLoad()

        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 1)
        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 1) == 2)
    }

    func testTableViewDataSourceReturnsPostTableViewCellAtSectionZero() {
        sut.view = commentListViewController
        sut.viewDidLoad()

        let cell = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(cell as? PostTableViewCell)
        XCTAssertNotNil((cell as? PostTableViewCell)?.canAddFavouritePost)
        XCTAssertEqual((cell.subviews[1] as? UIButton)?.title(for: .normal), "FAV")
        XCTAssertEqual((cell.subviews[2] as? UILabel)?.text, "some-title")
        XCTAssertEqual((cell.subviews[3] as? UILabel)?.text, "some-body")
    }

    func testTableViewDataSourceReturnsCommentTableViewCellAtSectionOne() {
        sut.view = commentListViewController
        sut.viewDidLoad()

        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "reuseIdentifer")

        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1))

        XCTAssertNotNil(cell as? CommentTableViewCell)
        XCTAssertEqual((cell.subviews[1] as? UILabel)?.text, "some@name-0.com")
        XCTAssertEqual((cell.subviews[2] as? UILabel)?.text, "some-body-0")
    }

    func testAddFavouritePost() {
        let post = Post(userId: 1, id: 1, title: "some-title", body: "some-body")

        sut.addFavouritePost(post)

        XCTAssertEqual(userManager.favouritePostToAdd, post)
    }

    class PostFetcherMock: PostFetcher {
        var commentsCalled = false

        func fetch(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {

        }

        func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void) {
            commentsCalled = true
            onSuccess([Comment(postId: 1, id: 1, name: "some-name-0", email: "some@name-0.com", body: "some-body-0"),
                       Comment(postId: 1, id: 2, name: "some-name-1", email: "some@name-1.com", body: "some-body-1")])
        }
    }

    class CommentListViewControllerMock: CommentListViewController {
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
                return [Post(userId: 1, id: 1, title: "fav-post-title", body: "fav-post-body")]
            }
            set {

            }
        }

        func addFavouritePost(_ post: Post) {
            favouritePostToAdd = post
        }
    }
}

