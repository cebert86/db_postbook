import XCTest
@testable import DB_Postbook

class PostListPresenterImplTests: XCTestCase {

    var postFetcher: PostFetcherMock!

    var sut: PostListPresenterImpl!

    override func setUp() {
        postFetcher = PostFetcherMock()

        sut = PostListPresenterImpl(postFetcher: postFetcher)
    }

    func testViewDidLoadFetchesPostsForUserId() {
        sut.viewDidLoad()

        XCTAssertTrue(postFetcher.fetchCalled)
    }

    class PostFetcherMock: PostFetcher {
        var fetchCalled = false

        func fetch(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
            fetchCalled = true
        }
    }
}

