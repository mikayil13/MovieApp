//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
import FirebaseFirestore
import Alamofire
import FirebaseAuth

class MovieDetailViewModel {
    var data: MovieDetail?
    var similarMovies = [MovieResult]()
    var movieId: Int?
    var video = [VideoResult]()
    var trailer: VideoResult?
    private let similarManager = SimilarManager()
    private let detailManager = MovieDetailManager()
    private let videoManager = VideoManager()
    var errorHandler: ((String) -> Void)?
    var success: (() -> Void)?
    
    // completion blokunda success parametrini qəbul edirik
    func getMovieDetail(completion: @escaping (Bool) -> Void) {
        guard let movieId = self.movieId else {
            errorHandler?("Movie ID mövcud deyil.")
            completion(false)
            return
        }
        detailManager.getMovieDetail(id: movieId) { data, error in
            if let data {
                print("MovieDetailViewModel - Məlumat gəldi: \(data.title ?? "Bilinməyən")") // Debug
                self.data = data
                completion(true) // Uğurlu olduqda success = true
            } else if let error {
                print("MovieDetailViewModel - Xəta: \(error)") // Debug
                self.errorHandler?(error)
                completion(false) // Xəta olduqda success = false
            }
        }
    }
    func fetchSimilarMovies(movieId: Int, completion: @escaping (Bool) -> Void) {
        guard let movieId = self.movieId else {
            completion(false)
            return
        }
        
        similarManager.getSimilarMovies(movieId: movieId) { data, error in
            if let data {
                self.similarMovies = data.results ?? []
                completion(true) // Uğurlu olduqda true göndəririk
            } else if let error {
                self.errorHandler?(error)
                completion(false) // Xəta olduqda false göndəririk
            }
        }
    }
    func getVideos() {
        videoManager.getVideos(movieId: movieId ?? 0) { data, error in
            if let data {
                self.video = data.results ?? []
                print("Gələn video məlumatları: \(data)")
                if let trailer = self.video.first(where: { $0.type == "Trailer" }) {
                    print("Tapılan Trailer Key: \(String(describing: trailer.key))")
                } else {
                    print(" Trailer tapılmadı!")
                }
                
                self.success?()
            } else if let error {
                print(" Error fetching videos: \(error)")
                self.errorHandler?(error)
            }
        }
    }
}
