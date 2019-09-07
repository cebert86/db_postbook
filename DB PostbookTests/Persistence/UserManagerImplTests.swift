import XCTest
@testable import DB_Postbook

class UserManagerImplTests: XCTestCase {

    var userDefaults: UserDefaults!

    var sut: UserManager!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: "TestUserDefaults")
        sut = UserManagerImpl(userDefaults: userDefaults)

        userDefaults.removePersistentDomain(forName: "TestUserDefaults")
        userDefaults.synchronize()
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

    func testAddFavouritePost() {
        sut.currentUserId = 1
        let post = Post(userId: 1, id: 1, title: "some-title", body: "some-body")

        sut.addFavouritePost(post)

        XCTAssert(sut.favouritePosts.count == 1)
        XCTAssertEqual(sut.favouritePosts.first, post)
    }

    func testAddFavouritePostDoesNotAddDuplicates() {
        sut.currentUserId = 1
        let post = Post(userId: 1, id: 1, title: "some-title", body: "some-body")

        sut.addFavouritePost(post)
        sut.addFavouritePost(post)

        XCTAssert(sut.favouritePosts.count == 1)
        XCTAssertEqual(sut.favouritePosts.first, post)
    }
}



