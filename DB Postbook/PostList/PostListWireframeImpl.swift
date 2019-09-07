import UIKit

class PostListWireframeImpl: PostListWireframe {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func showPostList(on viewController: UIViewController) {
        navigationController.setViewControllers([PostListViewController()], animated: true)
        viewController.show(navigationController, sender: nil)
    }
}
