//
//  NetworkingManager.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import Foundation
import Alamofire
class NetworkingManager {
    func request<T: Codable>(path: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)) {
        AF.request(path,
                   method: method,
                   parameters: params,
                   encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: NetworkingHelper.shared.header).responseDecodable(of: model.self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    

    }
    func getMovieList(page: Int, endpoint: MovieEndpoint, completion: @escaping ((Movie?, String?) -> Void)) {
          let path = endpoint.path + "\(page)"
          request(path: path, model: Movie.self, completion: completion)
      }
  }

