//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
enum MovieEndpoint: String {
    case nowPlaying = "movie/now_playing?page="
    case popular = "movie/popular?page="
    case topRated = "movie/top_rated?page="
    case upcoming = "movie/upcoming?page="
    
    var path: String {
        NetworkingHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
