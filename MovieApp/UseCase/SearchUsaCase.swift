//
//  SearchUsaCase.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation

protocol SearchUseCase {
    func searchMovies(query: String, page: Int, completion: @escaping ((Movie?, String?) -> Void))
}

