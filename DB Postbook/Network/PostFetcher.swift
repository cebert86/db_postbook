import Foundation

protocol PostFetcher {
    func fetch(for userId: Int, onSuccess: @escaping (_ : [Post]) -> Void, onError: @escaping (_ : Error) -> Void)
}
