//
//  GenreModel.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation
struct  Genre: Codable {
    let genres: [GenreElement]?
}
struct GenreElement: Codable {
    let id: Int?
    let name: String?
}
