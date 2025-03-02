//
//  NetworkingHelper.swift
//  MovieApp
//
//  Created by Mikayil on 16.02.25.
//

import Foundation
import Alamofire

class NetworkingHelper {
    static let shared = NetworkingHelper()
    let baseURL = "https://api.themoviedb.org/3/"
    let imageBaseURL = "https://image.tmdb.org/t/p/original"
    let header: HTTPHeaders = [
        "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"
    ]
    
    func configureURL(endpoint: String) -> String {
        return baseURL + endpoint
    }
}
