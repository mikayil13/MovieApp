
import UIKit

class ActorController: UIViewController {
    private var actors: [ActorResult] = []  // Bu da burada müəyyən edilməlidir
    private let viewModel = ActorViewModel()
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return rc
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 70
        layout.sectionInset = .init(top: 16, left: 24, bottom: 44, right: 16)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(ActorCell.self, forCellWithReuseIdentifier: "\(ActorCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        collection.frame = view.bounds
        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collection)
        collection.frame = view.bounds
        collection.refreshControl = refreshControl
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Actors"
    }
    
    private func configureViewModel() {
        viewModel.fetchActors()
        viewModel.completion = {
            // Aktyorları yüklədikdən sonra məlumatları yeniləyirik
            self.collection.reloadData()
            self.collection.refreshControl?.endRefreshing()
        }
        viewModel.errorHandler = { [weak self] error in
            // Hata mesajı göstəririk
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
            self?.collection.refreshControl?.endRefreshing()
        }
    }

    
    @objc private func refreshData() {
        self.viewModel.reset()
        self.viewModel.fetchActors()
    }
}

//MARK: - Setup collection

extension ActorController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.actors.count
    }
    
    // In ActorController where the cell is configured
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ActorCell.self)", for: indexPath) as! ActorCell
        let actor = viewModel.actors[indexPath.row]
        cell.configure(with: actor)
        
        // Assign the callback to handle actor selection
        cell.onActorSelected = { selectedActor in
            // Handle actor selection, e.g., push to another view controller
            let actorDetailVC = ActorMoviesController(actorID: selectedActor.id!)
            self.navigationController?.pushViewController(actorDetailVC, animated: true)
        }
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 180, height: 320)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actorID = viewModel.actors[indexPath.row].id!
        let vc = ActorMoviesController(actorID: actorID)
        vc.viewModel.actorId = actorID
        navigationController?.show(vc, sender: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
    
}
