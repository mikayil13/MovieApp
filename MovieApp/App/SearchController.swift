import UIKit

class SearchController: UIViewController {
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for movies..."
        textField.borderStyle = .none
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // 🔍 Search icon əlavə edirik
        let iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20) // 📌 İcon ortalanıb
        
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 44)) // 🔥 Hündürlük düzəldildi
        iconContainerView.addSubview(iconImageView)
        
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        return textField
    }()


    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        return tableView
    }()
    
    private var searchResults: [MovieResult] = []
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged) // 🔥 Mətni yazdıqca çağırılacaq
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func textFieldDidChange() {
        guard let query = searchTextField.text, !query.isEmpty else {
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
        fetchMovies(query: query)
    }
    
    private func fetchMovies(query: String) {
        viewModel.searchMovies(query: query) { [weak self] results in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchResults = results
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Klaviaturanı bağla
        if let query = textField.text, !query.isEmpty {
            fetchMovies(query: query)
        }
        return true
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        let movie = searchResults[indexPath.row]
        cell.configure(with: movie) 
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMovie = searchResults[indexPath.row]
        let detailsVC = MovieDetailsController()
        detailsVC.movieID = selectedMovie.id
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100 
       }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 20
       }
   }


