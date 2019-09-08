import UIKit

class CommentListWireframeImpl: CommentListWireframe {
    func showComments(on navigationController: UINavigationController, for post: Post) {
        let presenter = CommentListPresenterImpl(post: post)
        navigationController.pushViewController(CommentListViewController(presenter: presenter), animated: true)
    }
}
