//
//  ProductDetailsViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 15/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController
{

    /*============================================*/
        //MARK: Outlet Connections

    @IBOutlet weak var productPageControl: UIPageControl!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productInfo: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productDesc: UITextView!
    
    
    let arrOfImages :[String] = ["adidas1","adidas2","adidas3","adidas4"]
    /*============================================*/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imagesCollectionView.register(UINib(nibName: "PoductsImagesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imageCell")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUi()
        imagesCollectionView.register(UINib(nibName: "PoductsImagesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imagesCell")
       
    }
    

   
    func updateUi (){
        self.navigationItem.title = " ADICOLOR BACKPACK "
        productPrice.text = "EGP 749.00"
        productDesc.text = "When it comes to choosing the perfect bag for a busy day, space is key. Throw on this adidas backpack, and carry all your gear with ease. A roomy main compartment and front and side pockets let you keep your essentials organised and accessible. Plus, it's decked out in Trefoil logo style, so you can show off your adidas love on all your daily adventures. This product is made with Primegreen, a series of high-performance recycled materials"
        productInfo.text = " ADICOLOR BACKPACK SHADOW NAVY"
    }

}

extension ProductDetailsViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView
        {
        productPageControl.numberOfPages = 4
        return 4
        }else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imagesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PoductsImagesCollectionViewCell
            collectionView.isPagingEnabled = true
            cell.productImage.image = UIImage.init(named: arrOfImages[indexPath.row])
        return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.bounds.size.width , height: collectionView.bounds.size.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        productPageControl.currentPage = indexPath.row
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if productPageControl.currentPage == indexPath.row {
//            productPageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row-1
//        }
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
                let pageWidth = self.imagesCollectionView.frame.size.width
        productPageControl.currentPage = Int(self.imagesCollectionView.contentOffset.x / pageWidth)
            }
    
}
