//
//  HomeCell.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    private var title : UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints() {
        addSubview(title)
        addSubview(seeALLButton)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor ),
            title.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 32),
            seeALLButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            seeALLButton.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -12)
            
            ])
      
           
    }
    
    
    @objc private func seeALLButtonTapped() {
        
    }
     
}
