//
//  GenreModel.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import Foundation


// MARK: - Genre
struct  Genre: Codable {
    let genres: [GenreElement]?
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int?
    let name: String?
}
