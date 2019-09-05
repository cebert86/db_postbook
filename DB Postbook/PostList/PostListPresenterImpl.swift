class PostListPresenterImpl: PostListPresenter {

    private let postFetcher: PostFetcher
    public weak var view: PostListViewController?

    init(postFetcher: PostFetcher = PostFetcherImpl()) {
        self.postFetcher = postFetcher
    }

    func viewDidLoad() {
        postFetcher.fetch(for: 1, onSuccess: { post in

        }, onError: { error in
            
        })
    }
}
