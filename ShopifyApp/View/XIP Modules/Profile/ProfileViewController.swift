//
//  ProfileViewController.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/16/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
/*============================================================================*/
    //MARK: Constants & Variables
    
/*============================================================================*/
    //MARK: Outlet Connections
    
    
    
/*============================================================================*/
    //MARK: ViewController LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
/*===========================================================================*/
    //MARK: Actions Connections
    @objc func goToSettings(_ sender: UIBarButtonItem) {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToCart(_ sender: UIBarButtonItem) {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
/*===========================================================================*/
    //MARK: Services Functions
    func updateUI() {
        //set title for viewController
        self.navigationItem.title = "Profile"
        
        //create barButtonitem and add to navigation Bar
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(goToSettings(_:)))
        let cartButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(goToCart(_:)))
        navigationItem.rightBarButtonItems = [settingButton, cartButton]
    }

}
