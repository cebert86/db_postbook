import UIKit

class PostListPresenterImpl: NSObject, PostListPresenter, UITableViewDataSource {

    private let postFetcher: PostFetcher

    private var posts: [Post] = []
    public weak var view: PostListViewController?

    init(postFetcher: PostFetcher = PostFetcherImpl()) {
        self.postFetcher = postFetcher
    }

    func viewDidLoad() {
        postFetcher.fetch(onSuccess: { posts in
            self.posts = posts
            self.view?.reloadTableView()
        }, onError: { error in
            //TODO: Present error
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }
}
