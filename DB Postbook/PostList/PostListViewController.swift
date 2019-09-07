import UIKit

class PostListViewController: UIViewController {

    private var presenter: PostListPresenter

    private let segmentedControl = UISegmentedControl(items: ["Alle Posts", "Favoriten"])
    private let tableView = UITableView()

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

        configureSegmentedControl()
        configureTableView()

        presenter.viewDidLoad()
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    private func configureSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            } else {
                make.top.equalToSuperview()
            }
        }

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlTapped), for: .valueChanged)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
        }

        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reuseIdentifer")
        tableView.dataSource = presenter as? UITableViewDataSource
    }

    @objc
    private func segmentedControlTapped() {
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        presenter.segmentedControlTapped(index: segmentedControl.selectedSegmentIndex)
    }
}
