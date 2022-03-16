//
//  BrandProductsViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 16/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class BrandProductsViewController: UIViewController {

    /*============================================*/
        //MARK: Outlet Connections
    
    @IBOutlet weak var brandProducts: UICollectionView!
    
    
    
    /*============================================*/
       
    override func viewDidLoad() {
        super.viewDidLoad()
        brandProducts.register(UINib(nibName: "BrandProductsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "brandProductsCell")

    }
    

}
extension BrandProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.brandProducts
            {
                return 10
            }
            else{return 0}
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.brandProducts
            {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandProductsCell", for: indexPath) as! BrandProductsCollectionViewCell
                    return cell
            }
            else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandProductsCell", for: indexPath) as! BrandProductsCollectionViewCell
                    return cell
                }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (brandProducts.bounds.width)/2.5, height: (brandProducts.bounds.height)/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
        }

}
