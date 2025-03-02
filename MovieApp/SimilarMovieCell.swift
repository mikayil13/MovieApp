import UIKit
import Kingfisher

class SimilarMovieCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let reuseIdentifier = "SimilarMovieCell"
    var onMovieSelected: ((MovieResult) -> Void)?
   
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🎬 Similar Movies"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // CollectionView
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 120, height: 180)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var similarMovies: [MovieResult] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // 📌 Başlığı bir az aşağı salırıq
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4), // Əvvəl 20 idi
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // 📌 CollectionView-in üst boşluğunu artırırıq
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15), // Əvvəl 8 idi
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20), // Əlavə etdik!
            collectionView.heightAnchor.constraint(equalToConstant:240)
        ])
    }

    
    func configure(with similarMovies: [MovieResult]) {
        self.similarMovies = similarMovies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            fatalError("Dequeue cell failed")
        }
        let movie = similarMovies[indexPath.row]
        cell.configure(data: movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedMovie = similarMovies[indexPath.row]
            onMovieSelected?(selectedMovie)
        }
    }


