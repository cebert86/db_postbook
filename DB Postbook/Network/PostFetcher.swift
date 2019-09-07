import Foundation

protocol PostFetcher {
    func fetch(onSuccess: @escaping (_ : [Post]) -> Void, onError: @escaping (_ : Error) -> Void)
}
