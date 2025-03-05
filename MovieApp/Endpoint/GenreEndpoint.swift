//
//  GenreEndpoint.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
enum GenreEndpoint: String {
    case genre = "genre/movie/list"
    
    var path: String {
        NetworkingHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
