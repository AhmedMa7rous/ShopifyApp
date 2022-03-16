//
//  HomeViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    /*============================================*/
        //MARK: Outlet Connections

   
    @IBOutlet weak var saleCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    /*============================================*/
    
    //MARK: Outlet Actions
    
  
    @IBAction func goToFavoriteMethod(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showFavoriteFromHomeSegue", sender: Any?.self)
    }
    
    @IBAction func goToCartMethod(_ sender: Any) {
        performSegue(withIdentifier: "goToCartFromHomeSegue", sender: Any?.self)
    }
    
    
    @IBAction func goToSearchMethod(_ sender: Any) {
        performSegue(withIdentifier: "goToSearchFromHomeSegue", sender: Any?.self)
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
extension  HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (collectionView)
        {
        case saleCollectionView :
            return 1
        case brandsCollectionView :
            return 1
        default :
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (collectionView)
        {
        case saleCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "salesCell", for: indexPath)
            return cell
        case brandsCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "saleCell", for: indexPath)
            return cell
        }
    }
    
}
