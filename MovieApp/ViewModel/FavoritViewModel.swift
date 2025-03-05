import Foundation
import FirebaseAuth
import FirebaseFirestore

class FavoritViewModel: ObservableObject {
    @Published var favoriteMovies: [FavoritModel] = []
    
    private let db = Firestore.firestore()
    
    private var userId: String {
        return Auth.auth().currentUser?.uid ?? "unknown_user"
    }
    
    func fetchFavorites() {
        db.collection("favorites").document(userId).collection("movies")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Favoritləri yükləyərkən xəta: \(error.localizedDescription)")
                    return
                }
                
                self.favoriteMovies = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    return FavoritModel(
                        id: document.documentID,
                        title: data["title"] as? String,
                        posterPath: data["posterPath"] as? String,
                        voteAverage: data["voteAverage"] as? Double,
                        releaseDate: data["releaseDate"] as? String,
                        genres: data["genres"] as? [Int] ?? [],
                        overview: data["overview"] as? String,
                        department: data["department"] as? String
                    )
                } ?? []
            }
    }
    
    func addToFavorites(movie: FavoritModel, completion: @escaping () -> Void) {
        let movieId = movie.id
        let movieRef = db.collection("favorites").document(userId).collection("movies").document(movieId)
        
        let movieData: [String: Any] = [
            "title": movie.title ?? "",
            "posterPath": movie.posterPath ?? "",
            "voteAverage": movie.voteAverage ?? 0,
            "releaseDate": movie.releaseDate ?? "",
            "genres": movie.genres ?? [],
            "overview": movie.overview ?? "",
            "department": movie.department ?? ""
        ]
        
        movieRef.setData(movieData) { error in
            if let error = error {
                print("❌ Favoritlərə əlavə edilərkən xəta: \(error.localizedDescription)")
            } else {
                print("✅ Film favorilərə əlavə olundu! Firebase yolu: favorites/\(self.userId)/movies/\(movieId)")
                
                // ✅ Düzəliş: Əlavə olunduqdan sonra yoxla
                self.isMovieFavorite(movieId: movieId) { isFavorite in
                    print("📌 Film favorit statusu yeniləndi: \(isFavorite)")
                }
                completion()
            }
        }
    }
    
    func isMovieFavorite(movieId: String, completion: @escaping (Bool) -> Void) {
        let movieRef = db.collection("favorites").document(userId).collection("movies").document(movieId)
        
        movieRef.getDocument { document, error in
            if let error = error {
                print("❌ Firestore-dan oxuyarkən xəta: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let document = document, document.exists {
                print("✅ Film favoritdir: \(movieId)")
                completion(true)
            } else {
                print("❌ Film favorit deyil: \(movieId)")
                completion(false)
            }
        }
    }
    func removeFromFavorites(movieId: String, completion: @escaping () -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let movieRef = db.collection("favorites").document(userId).collection("movies").document(movieId)

        movieRef.delete { error in
            if let error = error {
                print("❌ Film favoritdən silinərkən xəta: \(error.localizedDescription)")
            } else {
                print("✅ Film favoritdən silindi: \(movieId)")
                completion()
            }
        }
    }


}

