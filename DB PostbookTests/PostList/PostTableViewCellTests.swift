import XCTest
@testable import DB_Postbook

class PostTableViewCellTests: XCTestCase {

    var sut: PostTableViewCell!

    override func setUp() {
        sut = PostTableViewCell(style: .default, reuseIdentifier: nil)

        sut.setPost(Post(userId: 1, id: 1, title: "some-title", body: "some-body"))
    }

    func testContainsTitleLabel() {
        let titleLabel = sut.subviews.first { subView in
            return (subView as? UILabel)?.text == "some-title"
        } as? UILabel

        XCTAssertNotNil(titleLabel)
        XCTAssertEqual(titleLabel?.font, UIFont.boldSystemFont(ofSize: 14))
        XCTAssert(titleLabel?.numberOfLines == 0)
    }

    func testContainsBodyLabel() {
        let bodyLabel = sut.subviews.first { subView in
            return (subView as? UILabel)?.text == "some-body"
        } as? UILabel

        XCTAssertNotNil(bodyLabel)
        XCTAssertEqual(bodyLabel?.font, UIFont.systemFont(ofSize: 14))
        XCTAssert(bodyLabel?.numberOfLines == 0)
    }

    func testContainsFavButton() {
        let favButton = sut.subviews.first { subView in
            return (subView as? UIButton)?.title(for: .normal) == "FAV"
        } as? UIButton

        XCTAssertNotNil(favButton)
        XCTAssertEqual(favButton?.titleColor(for: .normal), .blue)
    }
}


