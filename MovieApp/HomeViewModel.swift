//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import Foundation
class HomeViewModel {
    var movie: Movie?
    var movieItems = [MovieResult]()
    let manager = NetworkingManager()
    var errorHandling: ((String) -> Void)?
    var success: (() -> Void)?
    
    func getNowPlaying() {
        manager.reguest(endpoint: .nowPlaying,
                        model: Movie.self) { data,error in
            if let error {
                self.errorHandling?(error.localizedDescription)
            } else if let data {
                // self.movie = data
                self.movieItems = data.results ?? []
                self.success?()
            }
        }
    }
            func getPopular() {
                manager.reguest(endpoint: .popular,
                                model: Movie.self) { data,error in
                    if let error {
                        self.errorHandling?(error.localizedDescription)
                    } else if let data {
                        // self.movie = data
                        self.movieItems = data.results ?? []
                        self.success?()
                    }
                }
    }
                func getTopRated() {
                    manager.reguest(endpoint: .topRated,
                                    model: Movie.self) { data,error in
                        if let error {
                            self.errorHandling?(error.localizedDescription)
                        } else if let data {
                        //    self.movie = data
                            self.movieItems = data.results ?? []
                            self.success?()
                        }
                        func getUpcoming() {
                            manager.reguest(endpoint: .upcoming,
                                            model: Movie.self) { data,error in
                                if let error {
                                    self.errorHandling?(error.localizedDescription)
                                } else if let data {
                                    //  self.movie = data
                                    self.movieItems = data.results ?? []
                                    self.success?()
                                }
                    }
}
