import UIKit

class ActorMoviesController: UIViewController {
    var actorID: Int?
    var viewModel: ActorDetailViewModel
    var actorDetail: ActorResult?  
    var actorMovies: [MovieApp.Cast] = []
    private var loadingIndicator: UIActivityIndicatorView?

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
        
        collectionView.register(ActorMoviesHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ActorMoviesHeaderView")
        collectionView.register(ActorMovieDetailCell.self, forCellWithReuseIdentifier: "ActorMovieDetailCell")
        return collectionView
    }()
    init(actorID: Int) {
           self.actorID = actorID
           self.viewModel = ActorDetailViewModel(actorId: actorID)
           super.init(nibName: nil, bundle: nil) 
       }
       
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        loadData()
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        collectionView.frame = view.bounds
        setupLayout()
    }
    
    private func setupViewModel() {
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.hideLoadingIndicator()
            }
        }

        viewModel.errorHandler = { errorMessage in
            DispatchQueue.main.async {
                self.hideLoadingIndicator()
                print("Xəta baş verdi: \(errorMessage)")
            }
        }
    }
    
    private func loadData() {
        showLoadingIndicator()
        viewModel.fetchActorDetails()
        viewModel.fetchActorMovies()
        viewModel.fetchActorExternalIDs()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Loading indicator funksiyaları
    func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator!)
        
        NSLayoutConstraint.activate([
            loadingIndicator!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator!.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadingIndicator?.startAnimating()
    }

    func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
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
extension ActorMoviesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorMovieDetailCell", for: indexPath) as? ActorMovieDetailCell else {
                fatalError("ActorMovieDetailCell əldə edilə bilmədi.")
            }
            cell.configure(with: viewModel.actorMovies)
            
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
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ActorMoviesHeaderView", for: indexPath) as! ActorMoviesHeaderView
        
        // Əgər actorDetail məlumatı varsa
        if let actorDetail = viewModel.actorData {
            print("Actor Detail: \(actorDetail)") // Verilənlərə baxın
            if let actorExternalIDs = viewModel.actorExternalIDs {
                print("Actor External IDs: \(actorExternalIDs)") // Sosial şəbəkə məlumatlarına baxın
                header.configure(with: actorDetail, socialLinks: actorExternalIDs)
            } else {
                print("Actor External IDs tapılmadı")
            }
        } else {
            print("Actor Detail tapılmadı")
        }

        
        return header
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width, height: 220) // Bütün filmləri bir horizontal scroll içində göstərmək üçün
        }
        return .zero
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: collectionView.frame.width, height: 600) : .zero
    }

}

