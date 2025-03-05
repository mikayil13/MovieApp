//
//  MovieDetailManager.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class MovieDetailManager: MovieDetailUseCase {
    private let manager = NetworkingManager()
    func getMovieDetail(id: Int, completion: @escaping ((MovieDetail?, String?) -> Void)) {
        let path = MovieDetailEndpoints.detail(id: id).path
        print("📡 MovieDetail API çağırışı: \(path)") // Debug üçün
        
        manager.request(path: path, model: MovieDetail.self) { (movieDetail: MovieDetail?, error: String?) in
            if let error = error {
                print("❌ MovieDetail API xətası: \(error)") // Debug üçün
                completion(nil, error)
            } else if let movieDetail = movieDetail {
                print("✅ MovieDetail uğurla gəldi: \(movieDetail.title ?? "No Title")") // Debug üçün
                completion(movieDetail, nil)
            } else {
                print("❗ MovieDetail nil gəldi!")
                completion(nil, "Bilinməyən xəta baş verdi")
            }
        }
    }
    

}
