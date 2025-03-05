//
//  ActorDetailViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 10.02.25.
//

import Foundation

class ActorDetailViewModel {
    var actorData: ActorResult?
    var actorMovies = [Cast]()
    var actorId: Int
    var socialLinks: [String: String] = [:]
    var actorExternalIDs: ActorExternalIDs?
    private let manager = ActorManager()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(actorId: Int) {
        self.actorId = actorId
    }
    
    // Aktorun əsas məlumatlarını çək
    func fetchActorDetails() {
        manager.getActorDetails(actorId: actorId) { data, error in
            if let data {
                self.actorData = data
                self.success?()
            } else if let error {
                print("Error fetching actor details: \(error)")
                self.errorHandler?(error)
            }
        }
    }
    
    // Aktorun filmlərini çək
    func fetchActorMovies() {
        manager.getActorMovies(actorId: self.actorId) { data, error in
            if let data {
                self.actorMovies = data.cast ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func fetchActorExternalIDs() {
        manager.getActorExternalIDs(actorId: self.actorId) { data, error in
            if let data {
                self.actorExternalIDs = data
                print("Actor External IDs: \(data)") // API cavabını konsola çap et
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
