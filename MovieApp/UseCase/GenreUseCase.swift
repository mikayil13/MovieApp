//
//  GenreUseCase.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
protocol GenreUseCase {
    func getGenres(completion: @escaping((Genre?, String?) -> Void))
}
