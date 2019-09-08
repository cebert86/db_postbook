import UIKit

class CommentListPresenterImpl: NSObject, CommentListPresenter, UITableViewDataSource, CanAddFavouritePost {
    private let post: Post
    private let restApi: RestApi
    private let userManager: UserManager

    private var comments: [Comment] = []

    public weak var view: CommentListViewController?

    init(post: Post,
         restApi: RestApi = RestApiImpl(),
         userManager: UserManager = UserManagerImpl()) {
        self.post = post
        self.restApi = restApi
        self.userManager = userManager
    }

    func viewDidLoad() {
        fetchComments()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = PostTableViewCell(style: .default, reuseIdentifier: nil)
            cell.setPost(post)
            cell.canAddFavouritePost = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifer", for: indexPath) as! CommentTableViewCell
            cell.setComment(comments[indexPath.row])
            return cell
        }
    }

    func addFavouritePost(_ post: Post) {
        userManager.addFavouritePost(post)
    }

    private func fetchComments() {
        restApi.comments(for: post.id, onSuccess: { comments in
            self.comments = comments
            self.view?.reloadTableView()
        }, onError: { error in
            self.view?.presentSimpleErrorAlert()
        })
    }
}
