//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            // Storyboard-dan HomeController instansiyası yaradılır.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController") as? HomeController else {
                return
            }
            
            let tabBarController = UITabBarController()
            
            // Home Sekmesi
            let homeNav = UINavigationController(rootViewController: homeController)
            homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            
            // Search Sekmesi
            let searchController = SearchController()
            let searchNav = UINavigationController(rootViewController: searchController)
            searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
            
            // Actor Sekmesi
            let profileController = ActorController()
            let profileNav = UINavigationController(rootViewController: profileController)
            profileNav.tabBarItem = UITabBarItem(title: "Actor", image: UIImage(systemName: "person"), tag: 2)
            
           let favoriteController = FavoriteController()
            let favoriteNav = UINavigationController(rootViewController: favoriteController)
            favoriteNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "bookmark.fill"), tag: 3)  // "bookmark.fill" simgesi

            tabBarController.viewControllers = [homeNav, searchNav, profileNav, favoriteNav]
            
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = tabBarController
            window?.overrideUserInterfaceStyle = .light
            window?.makeKeyAndVisible()
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

