protocol UserManager {
    var currentUserId: Int { get set }
    var favouritePosts: [Post] { get set }

    func addFavouritePost(_ post: Post)
}
