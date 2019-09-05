import UIKit

class PostListViewController: UIViewController {

    private var presenter: PostListPresenter

    init(presenter: PostListPresenter = PostListPresenterImpl()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        defer {
            self.presenter.view = self
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Do not call from storyboard!")
    }

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        presenter.viewDidLoad()
    }
}
