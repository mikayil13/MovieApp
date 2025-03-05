

import Foundation

enum ActorEndpoint {
    case actor(page: Int)
    case detail(id: Int)
    case actorMovies(id: Int)
    case externalIDs(id: Int)
    
    var path: String {
        switch self {
        case .actor(let page):
            return NetworkingHelper.shared.configureURL(endpoint: "person/popular?page=\(page)")
        case .detail(let id):
            return NetworkingHelper.shared.configureURL(endpoint: "person/\(id)")
        case .actorMovies(let id):
            return NetworkingHelper.shared.configureURL(endpoint: "person/\(id)/movie_credits")
        case .externalIDs(let id): 
            return NetworkingHelper.shared.configureURL(endpoint: "person/\(id)/external_ids")
        }
    }
}

