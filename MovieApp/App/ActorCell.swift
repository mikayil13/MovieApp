import UIKit
import Kingfisher

class ActorCell: UICollectionViewCell {
    
    var onActorSelected: ((ActorResult) -> Void)?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center  // Texti mərkəzləşdiririk
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
        
            NSLayoutConstraint.activate([
                actorImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                actorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                actorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                actorImageView.heightAnchor.constraint(equalToConstant: 250), // Sekilin hündürlüyünü biraz azaldım
                
                nameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 12), // Sekilin altından 12 piksel boşluq
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with actor: ActorResult) {
        // Aktorun adını göstərmək
        nameLabel.text = actor.name
        
        // Şəkil URL-ni düzəldirik
        let imageUrl = "https://image.tmdb.org/t/p/w500\(actor.profilePath ?? "")"
        
        if let url = URL(string: imageUrl) {
            // Şəkil yüklənir
            actorImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder_actor"))
        } else {
            actorImageView.image = UIImage(named: "placeholder_actor")
        }
    }

    }

