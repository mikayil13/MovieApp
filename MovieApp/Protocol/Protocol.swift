//
//  Protocol.swift
//  MovieApp
//
//  Created by Mikayil on 24.02.25.
//

import Foundation
protocol MovieCellProtocol {
    var titleText: String { get }
    var imageURL: String { get }
    var overviewText: String { get }
    var departmentText: String { get }
    var cellVoteAverage: Double { get }
    var cellReleaseDate: String { get }
    var cellGenres: [Int] { get }
}
