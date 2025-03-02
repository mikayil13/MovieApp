import UIKit
import Kingfisher

class ActorMoviesHeaderView: UICollectionReusableView {
    
    private var actorMovies: [Cast] = []
    var onMovieSelected: ((Cast) -> Void)?
    
    // Sosial media ikonları üçün UIImageView
    private let facebookIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let twitterIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let instagramIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // UIStackView sosial media ikonları üçün
    private lazy var socialStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facebookIconImageView, twitterIconImageView, instagramIconImageView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.tintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var actorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "📖 About"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 9
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moviesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "🎬 Featured Movies"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(actorImage)
        addSubview(nameLabel)
        addSubview(birthInfoLabel)
        addSubview(socialStackView)
        addSubview(aboutLabel)
        addSubview(biographyLabel)
        addSubview(moviesTitleLabel)
        addSubview(separatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            actorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorImage.widthAnchor.constraint(equalToConstant: 150),
            actorImage.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            birthInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            birthInfoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            birthInfoLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            socialStackView.topAnchor.constraint(equalTo: birthInfoLabel.bottomAnchor, constant: 10),
            socialStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: socialStackView.bottomAnchor, constant: 16),
            aboutLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            biographyLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            biographyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            biographyLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            moviesTitleLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            moviesTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            moviesTitleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            moviesTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        // Biografiyanın maksimum hündürlüyü ilə bağlı məhdudiyyətlər əlavə edin
        biographyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        biographyLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actorImage.layer.cornerRadius = actorImage.frame.width / 2
    }
    
    func configure(with actor: ActorResult, socialLinks: SocialMediaProtocol?) {
        // Aktyor şəkli
        if let profilePath = actor.profilePath, !profilePath.isEmpty {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let fullURL = URL(string: baseURL + profilePath)
            actorImage.kf.setImage(with: fullURL, placeholder: UIImage(named: "placeholder_actor"))
        } else {
            actorImage.image = UIImage(named: "placeholder_actor")
        }
        
        nameLabel.text = actor.name ?? "Unknown Actor"
        
        // Doğum məlumatları
        let birthInfo = "Born: \(actor.birthday ?? "N/A")\n\(actor.placeOfBirth ?? "Unknown Location")"
        birthInfoLabel.text = birthInfo
        
        // Bioqrafiya
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributedText = NSAttributedString(string: actor.biography ?? "No biography available.", attributes: [.paragraphStyle: paragraphStyle])
        biographyLabel.attributedText = attributedText
        
        // Sosial media linklərini göstərmək
        socialStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // Əvvəlki düymələri təmizləyirik
        
        if let links = socialLinks {  // İndi sosial media məlumatlarının Optional olmasını qəbul etdik
            // Instagram varsa, əlavə edirik
            if let instagramURL = links.instagramURL, !instagramURL.isEmpty {
                if let url = URL(string: instagramURL) {
                    addSocialMediaButton(icon: "instagram_icon", url: url)
                }
            }
            
            // Twitter varsa, əlavə edirik
            if let twitterURL = links.twitterURL, !twitterURL.isEmpty {
                if let url = URL(string: twitterURL) {
                    addSocialMediaButton(icon: "twitter_icon", url: url)
                }
            }
            
            // Facebook varsa, əlavə edirik
            if let facebookURL = links.facebookURL, !facebookURL.isEmpty {
                if let url = URL(string: facebookURL) {
                    addSocialMediaButton(icon: "facebook_icon", url: url)
                }
            }
            
            // TikTok varsa, əlavə edirik
            if let tiktokURL = links.tiktokURL, !tiktokURL.isEmpty {
                if let url = URL(string: tiktokURL) {
                    addSocialMediaButton(icon: "tiktok_icon", url: url)
                }
            }
            
            // YouTube varsa, əlavə edirik
            if let youtubeURL = links.youtubeURL, !youtubeURL.isEmpty {
                if let url = URL(string: youtubeURL) {
                    addSocialMediaButton(icon: "youtube_icon", url: url)
                }
            }
        }
   }
    
    // Sosial media düyməsini əlavə etmək üçün funksiya
    private func addSocialMediaButton(icon: String, url: URL) {
        let button = UIButton()
        if let image = UIImage(named: icon) {
            button.setImage(image, for: .normal)
        } else {
            button.setTitle(icon.capitalized, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
        }
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addAction(UIAction(handler: { _ in
            UIApplication.shared.open(url)
        }), for: .touchUpInside)
        socialStackView.addArrangedSubview(button)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        socialStackView.arrangedSubviews.forEach { button in
            if let button = button as? UIButton {
                button.tintColor = UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark ? .white : .black
                }
            }
        }
    }
}

