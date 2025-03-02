import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavoriteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var favoriteMovies: [FavoritModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchFavorites()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    private func fetchFavorites() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("favorites")
            .document(userId).collection("movies")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }
    
    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.isEmpty ? 1 : favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if favoriteMovies.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "Favoritlər siyahısı boşdur"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.configure(with: favoriteMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

