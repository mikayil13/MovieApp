

import Foundation

class ActorViewModel {
    private var actor: Actor?
    var actors = [ActorResult]()
    private let manager = ActorManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func fetchActors() {
        print("fetchActors çağırıldı") // Konsol üçün
        manager.getActorList(page: (actor?.page ?? 0) + 1) { data, error in
            if let data {
                self.actor = data
                self.actors.append(contentsOf: data.results ?? [])
                print("Aktorlar yükləndi:", self.actors.count) // Konsola aktyor sayı
                
                // Hər aktyorun `profile_path`-ını çap edirik
                for actor in self.actors {
                    print("Aktor: \(actor.name ?? "Naməlum"), Profile Path: \(actor.profilePath ?? "Yoxdur")")
                }
                
                self.completion?()
            } else if let error {
                print("Xəta:", error) // Xətanı konsola çıxarın
                self.errorHandler?(error)
            }
        }
    }



    
    func pagination(index: Int) {
        if index == actors.count - 2 && (actor?.page ?? 0) <= (actor?.totalPages ?? 0) {
            fetchActors()
        }
    }
    
    func reset() {
        actor = nil
        actors.removeAll()
    }
}
