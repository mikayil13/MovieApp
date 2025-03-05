//
//  GenreManager.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
class GenreManager: GenreUseCase {
    let manager = NetworkingManager()
    
    func getGenres(completion: @escaping ((Genre?, String?) -> Void)) {
        let path = GenreEndpoint.genre.path
        
        manager.request(path: path,
                        model: Genre.self,
                        completion: completion)
    }
}
