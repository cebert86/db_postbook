import Foundation

class PostFetcherImpl: PostFetcher {

    func fetch(for userId: Int, onSuccess: @escaping ([Post]) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else {
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

    enum Failure: Swift.Error {
        case invalidUrl
    }
}
