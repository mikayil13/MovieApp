//
//   ActorManagerUseCase.swift
//  MovieApp
//
//  Created by Mikayil on 23.02.25.
//

import Foundation
protocol ActorManagerUseCase {
    func getActorList(page: Int, completion: @escaping((Actor?, String?) -> Void))
    func getActorDetails(actorId: Int, completion: @escaping((ActorResult?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping((ActorMovies?, String?) -> Void))
    func getActorExternalIDs(actorId: Int, completion: @escaping (ActorExternalIDs?, String?) -> Void)
   
}
