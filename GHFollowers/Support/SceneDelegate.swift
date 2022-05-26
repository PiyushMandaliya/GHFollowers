//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene       = (scene as? UIWindowScene) else { return }

        window                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        window?.rootViewController  = GFTabBarController()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }

    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
