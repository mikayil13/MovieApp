//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation

class SearchViewModel {
    private let searchManager = SearchManager()
    var searchResults: [MovieResult] = []
    
    func searchMovies(query: String, completion: @escaping ([MovieResult]) -> Void) {
        searchManager.searchMovies(query: query, page: 1) { [weak self] movie, error in
            guard let self = self, let movie = movie, let results = movie.results else {
                print(" Search failed: \(error ?? "Unknown error")")
                completion([])
                return
            }
            self.searchResults = results
            completion(results)
        }
    }
}
