import Foundation

class PostFetcherImpl: PostFetcher {

    private let userManager: UserManager

    init(userManager: UserManager = UserManagerImpl()) {
        self.userManager = userManager
    }

    func fetch(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userManager.currentUserId)") else {
            onError(Failure.invalidUrl)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let responseData = data, !responseData.isEmpty else {
                DispatchQueue.main.async { onSuccess([]) }
                return
            }

            guard error == nil else {
                DispatchQueue.main.async { onError(error!) }
                return
            }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: responseData)
                DispatchQueue.main.async { onSuccess(posts) }
            } catch {
                DispatchQueue.main.async { onError(error) }
            }
        }).resume()
    }

    func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            onError(Failure.invalidUrl)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let responseData = data, !responseData.isEmpty else {
                DispatchQueue.main.async { onSuccess([]) }
                return
            }

            guard error == nil else {
                DispatchQueue.main.async { onError(error!) }
                return
            }

            do {
                let comments = try JSONDecoder().decode([Comment].self, from: responseData)
                DispatchQueue.main.async { onSuccess(comments) }
            } catch {
                DispatchQueue.main.async { onError(error) }
            }
        }).resume()
    }

    enum Failure: Swift.Error {
        case invalidUrl
    }
}
