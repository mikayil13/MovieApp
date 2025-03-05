//
//  MovieDetailEndpoints.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation

enum MovieDetailEndpoints  {
    case detail(id: Int)
    
    var path: String {
        switch self {
        case .detail(let id):
            return NetworkingHelper.shared.configureURL(endpoint: "movie/\(id)")
        }
    }
    
}
