//
//  FavoritModel.swift
//  MovieApp
//
//  Created by Mikayil on 25.02.
//

import Foundation

struct FavoritModel: Codable, MovieCellProtocol {
    var id: String 
    var title: String?
    var posterPath: String?
    var voteAverage: Double?
    var releaseDate: String?
    var genres: [Int]?
    var overview: String?
    var department: String?

    var titleText: String {
        return title ?? "No Title"
    }
    
    var imageURL: String {
        return posterPath ?? ""
    }
    
    var overviewText: String {
        return overview ?? "No Overview"
    }
    
    var departmentText: String {
        return department ?? "No Department"
    }
    
    var cellVoteAverage: Double {
        return voteAverage ?? 0
    }
    
    var cellReleaseDate: String {
        return releaseDate ?? "Unknown Release Date"
    }
    
    var cellGenres: [Int] {
        return genres ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
        case voteAverage
        case releaseDate
        case genres
        case overview
        case department
    }
}

