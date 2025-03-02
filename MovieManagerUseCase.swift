//
//  MovieManagerUseCase.swift
//  MovieApp
//
//  Created by Mikayil on 19.02.25.
//

import Foundation
protocol MovieDetailUseCase {
    func getMovieDetail(id: Int, completion: @escaping((MovieDetail?, String?) -> Void))
}
