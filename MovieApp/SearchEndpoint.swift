//
//  SearchEndpoint.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation
enum SearchEndpoint {
    case searchMovie(query: String, page: Int)
    
    var path: String {
        switch self {
        case .searchMovie(let query, let page):
            let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return NetworkingHelper.shared.configureURL(endpoint: "search/movie?query=\(queryEncoded)&page=\(page)")
        }
    }
    
}
