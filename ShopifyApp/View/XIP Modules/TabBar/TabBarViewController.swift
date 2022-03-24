//
//  TabBarViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
/*===============================================*/
    //MARK: TabBar ViewControllers
    lazy var home: UIViewController = {
        let vc = HomeViewController()
        vc.tabBarItem.image = UIImage(systemName: "house")
        vc.tabBarItem.title = "Home"
        let navigation = UINavigationController(rootViewController: vc)
        navigation.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigation.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.5568627451, blue: 0.2431372549, alpha: 1)
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return navigation
    }()
    
    lazy var categories: UIViewController = {
        let vc = CategoriesViewController()
        vc.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        vc.tabBarItem.title = "Categories"
        let navigation = UINavigationController(rootViewController: vc)
        navigation.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigation.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.5568627451, blue: 0.2431372549, alpha: 1)
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return navigation
    }()
    
    lazy var profile: UIViewController = {
        let vc = ProfileViewController()
        vc.tabBarItem.image = UIImage(systemName: "person.circle")
        vc.tabBarItem.title = "Me"
        let navigation = UINavigationController(rootViewController: vc)
        navigation.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigation.navigationBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.5568627451, blue: 0.2431372549, alpha: 1)
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        return navigation
    }()
/*=================================================================*/
    //MARK: TabBar LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.368627451, green: 0.5568627451, blue: 0.2431372549, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        setViewControllers([home, categories, profile], animated: true)
    }

    
}
