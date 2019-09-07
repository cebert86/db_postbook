protocol PostListPresenter {
    var view: PostListViewController? { set get }

    func viewDidLoad()
    func segmentedControlTapped(index: Int)
}
