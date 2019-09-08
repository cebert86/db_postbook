import XCTest
@testable import DB_Postbook

class PostListPresenterImplTests: XCTestCase {

    var restApi: RestApiMock!
    var userManager: UserManagerMock!
    var commentListWireframe: CommentListWireframeMock!
    var postListViewController: PostListViewControllerMock!

    var sut: PostListPresenterImpl!

    override func setUp() {
        restApi = RestApiMock()
        userManager = UserManagerMock()
        commentListWireframe = CommentListWireframeMock()
        postListViewController = PostListViewControllerMock()

        sut = PostListPresenterImpl(restApi: restApi,
                                    userManager: userManager,
                                    commentListWireframe: commentListWireframe)
    }

    func testViewDidLoadFetchesPostsForUserId() {
        sut.viewDidLoad()

        XCTAssertTrue(restApi.fetchCalled)
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

    func testSegmentedControlTappedWithFavouriteIndexReloadsTableView() {
        sut.view = postListViewController

        sut.segmentedControlTapped(index: 1)

        XCTAssertTrue(postListViewController.reloadTableViewCalled)
    }

    func testSegmentedControlSwitchToFavouritePostsHasCorrectItems() {
        sut.view = postListViewController

        sut.viewDidLoad()
        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 2)

        sut.segmentedControlTapped(index: 1)
        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 1)
    }

    func testSegmentedControlSwitchToAllPostsFetchesPosts() {
        sut.view = postListViewController

        sut.segmentedControlTapped(index: 0)

        XCTAssertTrue(restApi.fetchCalled)
    }

    func testSegmentedControlSwitchToAllPostsHasCorrectItems() {
        sut.view = postListViewController

        sut.segmentedControlTapped(index: 1)
        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 1)

        sut.segmentedControlTapped(index: 0)
        XCTAssert(sut.tableView(UITableView(), numberOfRowsInSection: 0) == 2)
    }

    func testPostSelectionShowsComments() {
        sut.view = postListViewController
        sut.viewDidLoad()

        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reuseIdentifer")

        sut.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(commentListWireframe.showCommentsCalled)
    }

    class RestApiMock: RestApi {
        var fetchCalled = false

        func fetchPosts(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
            fetchCalled = true
            onSuccess([Post(userId: 1, id: 1, title: "some-title-1", body: "some-body-1"),
                       Post(userId: 1, id: 2, title: "some-title-2", body: "some-body-2")])
        }

        func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void) {

        }
    }

    class PostListViewControllerMock: PostListViewController {
        var reloadTableViewCalled = false

        override func reloadTableView() {
            reloadTableViewCalled = true
        }

        override var navigationController: UINavigationController? {
            return UINavigationController()
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

    class CommentListWireframeMock: CommentListWireframe {
        var showCommentsCalled = false

        func showComments(on navigationController: UINavigationController, for post: Post) {
            showCommentsCalled = true
        }
    }
}

