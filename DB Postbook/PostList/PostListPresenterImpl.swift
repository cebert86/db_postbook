import UIKit

class PostListPresenterImpl: NSObject, PostListPresenter, UITableViewDataSource, UITableViewDelegate, CanAddFavouritePost {

    private let restApi: RestApi
    private let userManager: UserManager
    private let commentListWireframe: CommentListWireframe

    private var posts: [Post] = []
    public weak var view: PostListViewController?

    init(restApi: RestApi = RestApiImpl(),
         userManager: UserManager = UserManagerImpl(),
         commentListWireframe: CommentListWireframe = CommentListWireframeImpl()) {
        self.restApi = restApi
        self.userManager = userManager
        self.commentListWireframe = commentListWireframe
    }

    func viewDidLoad() {
        fetchPosts()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifer", for: indexPath) as! PostTableViewCell
        cell.setPost(posts[indexPath.row])
        cell.canAddFavouritePost = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = view?.navigationController else {
            return
        }

        commentListWireframe.showComments(on: navigationController, for: posts[indexPath.row])
    }

    func addFavouritePost(_ post: Post) {
        userManager.addFavouritePost(post)
    }

    func segmentedControlTapped(index: Int) {
        if index == 1 {
            posts = userManager.favouritePosts
            self.view?.reloadTableView()
        } else {
            fetchPosts()
        }
    }

    private func fetchPosts() {
        restApi.fetchPosts(onSuccess: { posts in
            self.posts = posts
            self.view?.reloadTableView()
        }, onError: { error in
            //TODO: Present error
        })
    }
}
