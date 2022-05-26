//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers          = [createSearchNavigationController(),createFavoritesListNavigationController()]

    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC            = SearchVC()
        searchVC.title          = "Search"
        searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
        
    func createFavoritesListNavigationController() -> UINavigationController {
        let favoritesListVC         = FavoriteListVC()
        favoritesListVC.title       = "Favorite"
        favoritesListVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
