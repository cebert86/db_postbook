import XCTest
@testable import DB_Postbook

class CommentTableViewCellTests: XCTestCase {

    var sut: CommentTableViewCell!

    override func setUp() {
        sut = CommentTableViewCell(style: .default, reuseIdentifier: nil)

        sut.setComment(Comment(postId: 1, id: 1, name: "some-name", email: "some@mail.com", body: "some-body"))
    }

    func testContainsUsernameLabel() {
        let usernameLabel = sut.subviews.first { subView in
            return (subView as? UILabel)?.text == "some@mail.com"
            } as? UILabel

        XCTAssertNotNil(usernameLabel)
        XCTAssertEqual(usernameLabel?.font, UIFont.boldSystemFont(ofSize: 14))
        XCTAssert(usernameLabel?.numberOfLines == 0)
    }

    func testContainsBodyLabel() {
        let bodyLabel = sut.subviews.first { subView in
            return (subView as? UILabel)?.text == "some-body"
            } as? UILabel

        XCTAssertNotNil(bodyLabel)
        XCTAssertEqual(bodyLabel?.font, UIFont.systemFont(ofSize: 14))
        XCTAssert(bodyLabel?.numberOfLines == 0)
    }
}


