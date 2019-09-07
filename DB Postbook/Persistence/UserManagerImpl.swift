import Foundation

class UserManagerImpl: UserManager {

    private let userDefaults: UserDefaults

    private let currentUserIdKey = "currentUserId"
    private let favouritePostsKey = "favouritePosts-{{userId}}"

    var currentUserId: Int {
        get {
            return userDefaults.integer(forKey: currentUserIdKey)
        }
        set {
            userDefaults.set(newValue, forKey: currentUserIdKey)
        }
    }

    var favouritePosts: [Post] {
        get {
            guard let favouritePosts = UserDefaults.standard.data(forKey: userSpecificFavouritePostsKey) else {
                return []
            }

            return (try? JSONDecoder().decode([Post].self, from: favouritePosts)) ?? []
        }
        set {
            let postsData = try? JSONEncoder().encode(newValue)
            userDefaults.set(postsData, forKey: userSpecificFavouritePostsKey)
        }
    }

    private var userSpecificFavouritePostsKey: String {
        return favouritePostsKey.replacingOccurrences(of: "{{userId}}", with: String(currentUserId))
    }

    init(userDefaults: UserDefaults = UserDefaults(suiteName: "ProdUserDefaults")!) {
        self.userDefaults = userDefaults
    }
}
