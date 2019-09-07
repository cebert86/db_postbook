class LoginPresenterImpl: LoginPresenter {

    private let postListWireframe: PostListWireframe
    private var userManager: UserManager

    public weak var view: LoginViewController?

    init(postListWireframe: PostListWireframe = PostListWireframeImpl(),
         userManager: UserManager = UserManagerImpl()) {
        self.postListWireframe = postListWireframe
        self.userManager = userManager
    }

    func loginButtonTapped(userId: Int) {
        guard let view = view else {
            return
        }

        userManager.currentUserId = userId
        postListWireframe.showPostList(on: view)
    }
}
