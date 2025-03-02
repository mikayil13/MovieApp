//
//  HomeCell.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var seeALLButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeALLButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 0)
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var data : [MovieResult] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints() {
        addSubview(titleLabel)
        addSubview(seeALLButton)
        addSubview(collection)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor ),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 32),
            seeALLButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeALLButton.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -12),
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
        
        
    }
    var movieCallback: ((Int) -> Void)?
    func configure (title: String ,  data: [MovieResult])  {
        self.data = data
        titleLabel.text = title
        collection.reloadData()
    }
    
    
    @objc private func seeALLButtonTapped() {
        
    }

}
extension HomeCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(data: data[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168 , height:  collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieCallback?(data[indexPath.row].id ?? 0)
    }
}
