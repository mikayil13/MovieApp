import UIKit
import Alamofire

class MovieDetailsController: UIViewController {
    var movieID: Int?
    let viewModel = MovieDetailViewModel()
    let manager = VideoManager()
    var movie: MovieDetail?
    let favoriteViewModel = FavoritViewModel()
    var isFavorite: Bool = false
    var favoriteButton: UIBarButtonItem! 
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }

        collectionView.register(MovieDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MovieDetailHeaderView")
        collectionView.register(SimilarMovieCell.self, forCellWithReuseIdentifier: "SimilarMovieCell")
        return collectionView
    }()
    
    var similarMovies: [MovieResult] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        collectionView.frame = view.bounds
        setupLayout()
        fetchDataVideo()
        fetchSimilarMovies()
        setupNavigationBar()
        favoriteViewModel.fetchFavorites()
              self.checkIfFavorite()
          
      
        
        
    }
    private func setupNavigationBar() {
        let bookmarkButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
        navigationItem.rightBarButtonItem = bookmarkButton
        updateBookmarkIcon()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavorite()
    }

    @objc private func toggleFavorite() {
        guard let movie = viewModel.data else { return }
        
        if isFavorite {
            favoriteViewModel.removeFromFavorites(movieId: "\(movie.id ?? 0)") { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.isFavorite = false
                    self?.updateBookmarkIcon()
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                        self?.checkIfFavorite()
                    }
                }
            }
        } else {
            let favoriteMovie = FavoritModel(
                id: "\(movie.id ?? 0)",
                title: movie.title,
                posterPath: movie.posterPath,
                voteAverage: movie.voteAverage,
                releaseDate: movie.releaseDate,
                overview: movie.overview
            )
            favoriteViewModel.addToFavorites(movie: favoriteMovie) { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isFavorite = true
                    self.updateBookmarkIcon()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.checkIfFavorite()
                    }
                }
            }
        }
        
    }
    private func checkIfFavorite() {
//        guard let movieID = movieID else { return }
        
        favoriteViewModel.isMovieFavorite(movieId: "\(movieID ?? 0)") { [weak self] isFav in
            guard let self = self else { return }
            print("📌 `checkIfFavorite` nəticəsi: \(isFav) \(movieID ?? 0)")
            self.isFavorite = isFav
            self.updateBookmarkIcon()
        }
    }


    private func updateBookmarkIcon() {
        let iconName = isFavorite ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: iconName)
    }

    func fetchSimilarMovies() {
        guard let movieID = movieID else {
            print("Error: Movie ID is not set!")
            return
        }
        
        viewModel.fetchSimilarMovies(movieId: movieID) { [weak self] success in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if success {
                    self.similarMovies = self.viewModel.similarMovies
                    print("Similar movies loaded successfully.")
                    self.collectionView.reloadData()
                } else {
                    print("Failed to load similar movies!")
                }
            }
        }
    }
    
    func fetchDataVideo() {
        guard let movieID = movieID else {
            print(" Error: Movie ID is not set!")
            return
        }

        print("Fetching videos for Movie ID: \(movieID)")

        viewModel.movieId = movieID
        viewModel.getMovieDetail { [weak self] success in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if success {
                    print("Movie data loaded successfully.")
                    self.collectionView.reloadData()

                    self.viewModel.getVideos()
                    print("Videos received: \(self.viewModel.video.map { "\($0.type ?? "Unknown"): \($0.key ?? "No Key")" })")
                    self.collectionView.reloadData()
                } else {
                    print("Error occurred while loading movie data!")
                }
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension MovieDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as? SimilarMovieCell else {
                fatalError("Failed to dequeue SimilarMovieCell")
            }
            cell.configure(with: similarMovies)
            
            cell.onMovieSelected = { [weak self] selectedMovie in
                guard let self = self else { return }
                let detailsVC = MovieDetailsController()
                detailsVC.movieID = selectedMovie.id
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }

            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          guard kind == UICollectionView.elementKindSectionHeader else {
              return UICollectionReusableView()
          }
          
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MovieDetailHeaderView", for: indexPath) as! MovieDetailHeaderView
          if let data = viewModel.data {
              header.configure(with: data)
          }
        header.videoCallback = {
                    let vc = TrailerController()
                    guard let key = self.viewModel.video.filter({$0.type == "Trailer"}).first?.key
                    else {
                        let alert = UIAlertController(title: "Error", message: "Trailer not found...", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        self.present(alert, animated: true)
                        return
                    }
                    vc.videoKey = key
                    self.navigationController?.show(vc, sender: nil)
                }
                return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 { 
            return CGSize(width: collectionView.frame.width - 25, height: 300)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: collectionView.frame.width, height: 500) : .zero
    }
}


