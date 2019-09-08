import Foundation

protocol PostFetcher {
    func fetch(onSuccess: @escaping (_ : [Post]) -> Void, onError: @escaping (_ : Error) -> Void)
    func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void)
}
