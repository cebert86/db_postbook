import XCTest
@testable import DB_Postbook

class UserManagerImplTests: XCTestCase {

    var sut: UserManager!

    override func setUp() {
        sut = UserManagerImpl(userDefaults: UserDefaults(suiteName: "TestUserDefaults")!)

        sut.currentUserId = 0
        sut.favouritePosts = []
    }

    override func tearDown() {
        sut.currentUserId = 0
        sut.favouritePosts = []
    }

    func testSaveCurrentUserId() {
        sut.currentUserId = 1
        XCTAssert(sut.currentUserId == 1)
        sut.currentUserId = 2
        XCTAssert(sut.currentUserId == 2)
    }

    func testSaveAndGetFavouritePostsForDifferentUserIds() {
        sut.currentUserId = 1

        let post1 = Post(userId: 88, id: 1, title: "some-title-1", body: "some-body-1")
        let post2 = Post(userId: 88, id: 2, title: "some-title-2", body: "some-body-2")

        sut.favouritePosts = [post1, post2]

        XCTAssert(sut.favouritePosts.count == 2)
        XCTAssertEqual(sut.favouritePosts[0], post1)
        XCTAssertEqual(sut.favouritePosts[1], post2)

        sut.currentUserId = 2

        let post3 = Post(userId: 99, id: 3, title: "some-title-3", body: "some-body-3")

        sut.favouritePosts = [post3]

        XCTAssert(sut.favouritePosts.count == 1)
        XCTAssertEqual(sut.favouritePosts[0], post3)
    }
}



