//
//  SimilarEndpoint.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import Foundation
enum SimilarEndpoint {
    case similarMovie(id: Int)
    
    var path: String {
        switch self {
        case .similarMovie(let id):
            return NetworkingHelper.shared.configureURL(endpoint: "movie/\(id)/similar")
        }
    }
}
