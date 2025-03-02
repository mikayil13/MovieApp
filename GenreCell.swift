//
//  GenreCell.swift
//  MovieApp
//
//  Created by Mikayil on 20.02.25.
//

import UIKit


class GenreCell: UICollectionViewCell {
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with genre: GenreElement) {
        print("Genre:", genre.name)
        genreLabel.text = genre.name
    }

}

