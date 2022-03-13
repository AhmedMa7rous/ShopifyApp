//
//  CategoryViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    /*============================================*/
    
    //MARK: Outlet Actions
    
  
    @IBAction func goToFavoriteMethod(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showFavoriteFromCategorySegue", sender: Any?.self)
    }
    
    @IBAction func goToCartMethod(_ sender: Any) {
        performSegue(withIdentifier: "goToCartFromCategorySegue", sender: Any?.self)
    }
    
    
    @IBAction func goToSearchMethod(_ sender: Any) {
        performSegue(withIdentifier: "goToSearchFromCategorySegue", sender: Any?.self)
    }
    
    
    
    /*============================================*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
