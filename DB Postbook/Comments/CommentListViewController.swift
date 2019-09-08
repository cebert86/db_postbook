import UIKit

class CommentListViewController: UIViewController {

    private var presenter: CommentListPresenter

    private let tableView = UITableView()

    init(presenter: CommentListPresenter) {
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

        configureTableView()

        presenter.viewDidLoad()
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "reuseIdentifer")
        tableView.dataSource = presenter as? UITableViewDataSource
    }
}
