//
//  SimilarManager.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import Foundation
class SimilarManager: SimilarUseCase {
    private let manager = NetworkingManager()
    
    func getSimilarMovies(movieId: Int, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = SimilarEndpoint.similarMovie(id: movieId).path
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
}
