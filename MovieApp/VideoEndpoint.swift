//
//  VideoEndpoint.swift
//  MovieApp
//
//  Created by Mikayil on 22.02.25.
//

import Foundation
enum VideoEndpoint {
    case video(id: Int)

    var path: String {
        switch self {
        case .video(let id):
            return "https://api.themoviedb.org/3/movie/\(id)/videos"
        }
    }
}

