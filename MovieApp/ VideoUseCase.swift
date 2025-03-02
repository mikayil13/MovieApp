//
//   VideoUseCase.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import Foundation
protocol VideoUseCase {
    func getVideos(movieId: Int, completion: @escaping ((Videos?, String?) -> Void))
}
