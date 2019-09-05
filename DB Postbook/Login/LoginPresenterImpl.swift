class LoginPresenterImpl: LoginPresenter {

    private let postListWireframe: PostListWireframe
    public weak var view: LoginViewController?

    init(postListWireframe: PostListWireframe = PostListWireframeImpl()) {
        self.postListWireframe = postListWireframe
    }

    func loginButtonTapped(userId: Int) {
        guard let view = view else {
            return
        }

        postListWireframe.showPostList(for: userId, on: view)
    }
}
