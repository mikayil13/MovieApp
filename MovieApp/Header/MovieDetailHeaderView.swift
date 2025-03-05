import UIKit
import Kingfisher

class MovieDetailHeaderView: UICollectionReusableView {
    private var movieGenres = [GenreElement]()
    private var trailerURL: URL?
    let viewModel = MovieDetailViewModel()
    var videoCallback: (() -> Void)?
    
    private lazy var playImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "play.circle.fill"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .red
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(watchTrailer)))
        iv.layer.zPosition = 10
        return iv
    }()
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateView: UILabel = createInfoLabel()
    private lazy var languageView: UILabel = createInfoLabel()
    private lazy var voteView: UILabel = createInfoLabel()
    private lazy var timeView: UILabel = createInfoLabel()
    
    private func createInfoLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateView, createSeparator(), languageView, createSeparator(), voteView, createSeparator(), timeView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func createSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
    
    private lazy var genreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "📖 About Movie"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray  // İstədiyiniz rəngi seçə bilərsiniz
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        
        addSubview(backImage)
        addSubview(playImage)
        addSubview(posterImage)
        addSubview(titleLabel)
        addSubview(infoStack)
        addSubview(genreCollection)
        addSubview(aboutMovieLabel)
        addSubview(descriptionLabel)
        addSubview(separatorLine) // Yeni xətti əlavə etdik
        bringSubviewToFront(playImage)
        
        genreCollection.dataSource = self
        genreCollection.delegate = self
        genreCollection.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: topAnchor),
            backImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 220),
            
            playImage.centerXAnchor.constraint(equalTo: backImage.centerXAnchor),
            playImage.centerYAnchor.constraint(equalTo: backImage.centerYAnchor),
            playImage.heightAnchor.constraint(equalToConstant: 60),
            playImage.widthAnchor.constraint(equalToConstant: 60),
            
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 140),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            posterImage.widthAnchor.constraint(equalToConstant: 110),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            infoStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoStack.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            genreCollection.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 20),
            genreCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            genreCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            genreCollection.heightAnchor.constraint(equalToConstant: 30),
            
            aboutMovieLabel.topAnchor.constraint(equalTo: genreCollection.bottomAnchor, constant: 24),
            aboutMovieLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aboutMovieLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: aboutMovieLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            separatorLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)  // Xəttin qalınlığını tənzimləyirik
        ])
    }
    
    func configure(with model: MovieDetail) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        if let backdropPath = model.backdropPath, !backdropPath.isEmpty {
            let fullBackdropURL = URL(string: baseURL + backdropPath)
            backImage.kf.setImage(with: fullBackdropURL)
        } else {
            backImage.image = UIImage(named: "placeholder_backdrop")
        }
        
        if let posterPath = model.posterPath, !posterPath.isEmpty {
            let fullPosterURL = URL(string: baseURL + posterPath)
            posterImage.kf.setImage(with: fullPosterURL)
        } else {
            posterImage.image = UIImage(named: "placeholder_poster")
        }
        
        titleLabel.text = model.title ?? "Unknown Title"
        dateView.text = model.formattedDate
        languageView.text = model.originalLanguage?.uppercased() ?? "N/A"
        voteView.text = model.voteAverage.map { "⭐ \($0)" } ?? "N/A"
        timeView.text = model.runtime.map { "\($0) min" } ?? "N/A"
        descriptionLabel.text = model.overview
        
        movieGenres = model.genres ?? []
        genreCollection.reloadData()
    }
    
    @objc private func watchTrailer() {
        videoCallback?()
    }
}

extension MovieDetailHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.configure(genre: movieGenres[indexPath.item].name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 4 - 10, height: 30)
    }
}
