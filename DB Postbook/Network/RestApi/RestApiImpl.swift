import Foundation

class RestApiImpl: RestApi {

    private let userManager: UserManager

    init(userManager: UserManager = UserManagerImpl()) {
        self.userManager = userManager
    }

    func fetchPosts(onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userManager.currentUserId)") else {
            onError(Failure.invalidUrl)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            self.handleResponse(data: data, error: error, onSuccess: onSuccess, onError: onError)
        }).resume()
    }

    func comments(for postId: Int, onSuccess: @escaping ([Comment]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            onError(Failure.invalidUrl)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            self.handleResponse(data: data, error: error, onSuccess: onSuccess, onError: onError)
        }).resume()
    }

    private func handleResponse<T: Codable>(data: Data?,
                                            error: Swift.Error?,
                                            onSuccess: @escaping ([T]) -> Void,
                                            onError: @escaping (Error) -> Void) {
        guard let responseData = data, !responseData.isEmpty else {
            DispatchQueue.main.async { onSuccess([]) }
            return
        }

        guard error == nil else {
            DispatchQueue.main.async { onError(error!) }
            return
        }

        do {
            let responseItems = try JSONDecoder().decode([T].self, from: responseData)
            DispatchQueue.main.async { onSuccess(responseItems) }
        } catch {
            DispatchQueue.main.async { onError(error) }
        }
    }

    enum Failure: Swift.Error {
        case invalidUrl
    }
}
