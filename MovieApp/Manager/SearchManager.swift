//
//  SearchManager.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation


class SearchManager: SearchUseCase {
    private let manager = NetworkingManager()
    
    func searchMovies(query: String, page: Int = 1, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = SearchEndpoint.searchMovie(query: query, page: page).path
        manager.request(path: path, model: Movie.self, completion: completion)
    }
}
