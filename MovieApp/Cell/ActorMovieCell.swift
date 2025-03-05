//
//  ActorMovieCell.swift
//  MovieApp
//
//  Created by Mikayil on 24.02.25.
//

import UIKit
import Kingfisher

class ActorMovieCell: UICollectionViewCell {
    var onMovieSelected: ((Cast) -> Void)? // Callback burada olacaq
    private var movie: Cast?
    static let reuseIdentifier = "ActorMovieCell"
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        
        // Gesture recognizer əlavə et
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(movieTapped))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Cast) {
        self.movie = movie
        titleLabel.text = movie.titleText
        
        // Image yükləmə logic
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie.posterPath, !posterPath.isEmpty {
            let url = URL(string: baseURL + posterPath)
            movieImage.kf.setImage(with: url)
        } else {
            movieImage.image = UIImage(named: "placeholder_movie")
        }
    }
    
    fileprivate func configureConstraints() {
        addSubview(titleLabel)
        addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ])
    }
    
    @objc private func movieTapped() {
        if let movie = movie {
            onMovieSelected?(movie) 
        }
    }
}
