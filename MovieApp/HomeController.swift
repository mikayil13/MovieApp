//
//  HomeController.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        let themeIcon = UIImage(systemName: getThemeIconName())?.withRenderingMode(.alwaysTemplate)
        let themeButton = UIBarButtonItem(image: themeIcon,
                                          style: .plain,
                                          target: self,
                                          action: #selector(toggleTheme))
        themeButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = themeButton
    }
    
    @objc private func toggleTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            print("Window tapılmadı!")
            return
        }
        
        let newStyle: UIUserInterfaceStyle = (window.overrideUserInterfaceStyle == .dark) ? .light : .dark
        window.overrideUserInterfaceStyle = newStyle
        
        let themeIcon = UIImage(systemName: getThemeIconName())?.withRenderingMode(.alwaysTemplate)
        navigationItem.rightBarButtonItem?.image = themeIcon
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
    }
    private func getThemeIconName() -> String {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return "sun.max.fill"
        }
        return (window.overrideUserInterfaceStyle == .dark) ? "moon.fill" : "sun.max.fill"
    }
    
    fileprivate func configureUI(){
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
    }
    
    fileprivate func configureViewModel(){
        viewModel.getAllData()
        viewModel.errorHandler = { error in
            print("Error: \(error)")
        }
        
        viewModel.completion = {
            self.collection.reloadData()
        }
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let model = viewModel.movieItems[indexPath.row]
        cell.configure(title: model.title, data: model.items)
        cell.movieCallback = { id in
          let vc = MovieDetailsController()
            vc.movieID = id
            self.navigationController?.show(vc, sender: nil)
//            guard let navigationController = navigationController else { return }
//            let coordinator = MovieDetailCoordinator(movie: movie, navigationController: navigationController)
//            coordinator.start()

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 320)
    }
}
