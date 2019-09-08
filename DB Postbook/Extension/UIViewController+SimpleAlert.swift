import UIKit

extension UIViewController {
    @objc func presentSimpleErrorAlert() {
        let message = "Ein technischer Fehler ist aufgetreten. Bitte versuchen Sie es später erneut."
        let alertController = UIAlertController(title: "Hinweis", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
