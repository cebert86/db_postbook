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

        XCTAssert(postFetcher.userId == 1)
    }

    class PostFetcherMock: PostFetcher {
        var userId = 0

        func fetch(for userId: Int, onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
            self.userId = userId
        }
    }
}

