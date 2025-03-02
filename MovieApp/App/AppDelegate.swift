//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Mikayil on 15.02.25.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        signInAnonymouslyIfNeeded()
        return true
    }
    private func signInAnonymouslyIfNeeded() {
        if let existingUserId = Auth.auth().currentUser?.uid {
            print("✅ Mövcud Firebase UID:", existingUserId)
        } else {
            Auth.auth().signInAnonymously { authResult, error in
                if let error = error {
                    print("❌ Firebase anonim giriş xətası:", error.localizedDescription)
                } else if let user = authResult?.user {
                    print("✅ Firebase anonim giriş uğurlu! UID:", user.uid)
                    UserDefaults.standard.set(user.uid, forKey: "firebaseUserId")
                }
            }
        }
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


