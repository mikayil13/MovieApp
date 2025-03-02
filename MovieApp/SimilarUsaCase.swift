//
//  SimilarUsaCase.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import Foundation
protocol SimilarUseCase {
    func getSimilarMovies(movieId: Int, completion: @escaping((Movie?, String?) -> Void))
}
