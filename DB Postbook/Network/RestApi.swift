import Foundation

protocol RestApi {
    func fetchPosts(onSuccess: @escaping (_ : [Post]) -> Void, onError: @escaping (_ : Error) -> Void)
    func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void)
}
