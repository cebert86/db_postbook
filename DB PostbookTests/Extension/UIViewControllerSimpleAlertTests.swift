import XCTest
@testable import DB_Postbook

class UIViewControllerSimpleAlertTests: XCTestCase {

    var window: UIWindow!

    var sut: UIViewController!

    override func setUp() {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))

        sut = UIViewController()

        window.rootViewController = sut
        window.makeKeyAndVisible()
    }

    func testPresentSimpleErrorAlertPresentsAlert() {
        sut.presentSimpleErrorAlert()

        let alertController = sut.presentedViewController as? UIAlertController
        XCTAssertEqual(alertController?.title, "Hinweis")
        XCTAssertEqual(alertController?.message, "Ein technischer Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.")
        XCTAssertEqual(alertController?.actions.first?.title, "OK")
    }
}



