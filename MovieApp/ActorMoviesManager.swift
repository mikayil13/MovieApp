//
//  ActorMoviesManager.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation
class ActorManager: ActorManagerUseCase {
    private let manager = NetworkingManager()
    
    func getActorList(page: Int, completion: @escaping ((Actor?, String?) -> Void)) {
        let path = ActorEndpoint.actor(page: page).path
        manager.request(path: path, model: Actor.self, completion: completion)
    }
    
    func getActorDetails(actorId: Int, completion: @escaping ((ActorResult?, String?) -> Void)) {
        let path = ActorEndpoint.detail(id: actorId).path
        manager.request(path: path, model: ActorResult.self, completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping ((ActorMovies?, String?) -> Void)) {
        let path = ActorEndpoint.actorMovies(id: actorId).path
        manager.request(path: path, model: ActorMovies.self, completion: completion)
    }
    func getActorExternalIDs(actorId: Int, completion: @escaping ((ActorExternalIDs?, String?) -> Void)) {
            let path = ActorEndpoint.externalIDs(id: actorId).path
            manager.request(path: path, model: ActorExternalIDs.self, completion: completion)
        }
    }

