//
//  NetworkingManager.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import Foundation
import Alamofire
enum Endpoint {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
}

enum EncodingType {
    case url
    case json
}


class NetworkingManager {
    let baseURL = "https://api.themoviedb.org/3"
    let header: HTTPHeader = [ "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"]
    
    func reguest<T: Codable> (endpoint: Endpoint,
                              model: T.Type,
                              method: HTTPMethod = .get,
                              params: Parameters? = nil,
                              encodingType: EncodingType = URLEncoding.default,
                             // headers: HTTPHeaders? = nil,
                              completion: @escaping((T?,String?) -> Void )) {
        AF.request("\(baseURL)/\(endpoint.rawValue)",
                   method: method,
                   parameters: params,
                   encoder: encodingType == .url ? URL8Encoding.default : JSONEncding.default,
                   headers: headers) .responseDecodable(of: model) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data, nil)
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                    }
                }
        }
    }

