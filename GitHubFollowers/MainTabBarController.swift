//
//  Tabbar.swift
//  GitHubFollowers
//
//  Created by Hakan Or on 12.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [
            createNavigationController(vc: SearchVC(), title: "Search", tabBarItem: .search, tag: 0),
            createNavigationController(vc: FavoritesListVC(), title: "Favorites", tabBarItem: .favorites, tag: 1)
            ]
        UITabBar.appearance().tintColor = .systemGreen // Change color of Tabbar Items
        UINavigationBar.appearance().tintColor = .systemGreen // Change color of back button etc. on navigationBar
    }
    
    private func createNavigationController(vc: UIViewController, title: String, tabBarItem: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
        let vc = vc
        vc.title = title
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarItem, tag: tag)
        return UINavigationController(rootViewController: vc)
    }
}
