//
//   MovieManagerUseCase.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation

protocol MovieManagerUseCase {
    func searchMovies()
    func getMovieList(page: Int, endpoint: MovieEndpoint, completion: @escaping((Movie?, String?) -> Void))
}
