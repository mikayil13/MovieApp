//
//  Endpoints.swift
//  MovieApp
//
//  Created by Mikayil on 16.02.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}

enum Endpoint : String {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case movieDetail = "movie/{movieId}"
    
    func path(withMovieId movieId: Int? = nil) -> String {
            switch self {
            case .movieDetail:
                guard let movieId = movieId else {
                    fatalError("Movie ID is required for movieDetail endpoint.")
                }
                return self.rawValue.replacingOccurrences(of: "{movieId}", with: "\(movieId)")
            default:
                return self.rawValue
            }
        }
    }

