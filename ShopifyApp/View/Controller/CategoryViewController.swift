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
    
    //MARK: proparty
    lazy var viewModel: CategoryViewControllerModel = {
           return CategoryViewControllerModel()
       }()
    /*============================================*/
        
    //MARK: Outlet Connections
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var productsClollectionView: UICollectionView!
    /*============================================*/
    
    //MARK: Outlet Actions
    
    @IBAction func changeCatagory(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.fetchProductsWithIB(collection_id: "272069099567")
        case 1:
            self.fetchProductsWithIB(collection_id: "272069034031")
        case 2:
            self.fetchProductsWithIB(collection_id: "272069066799")
        case 3:
            self.fetchProductsWithIB(collection_id: "272069132335")
            
            
        default:
            break
        }
    }
    
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
        let nib = UINib(nibName: "ProductsCollectionViewCell", bundle: nil)
        self.productsClollectionView.register(nib, forCellWithReuseIdentifier: "productCell")
        initVM()

        // Do any additional setup after loading the view.
    }
    /*============================================*/
    //MARK: Services Functions
    func initVM() {
        viewModel.reloadTableViewClosure = { [weak self] () in
                   DispatchQueue.main.async {
                       self?.productsClollectionView.reloadData()
                   }
               }
               
               viewModel.fetchProductAPI()

        
    }
    func  fetchProductsWithIB(collection_id : String){
        viewModel.fetchProductAPIWithIB(collection_id: collection_id)
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productsClollectionView.reloadData()
            }
        }
        
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
extension CategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsCollectionViewCell
        let cellVM = viewModel.getCellViewModel( at: indexPath )
               cell.productListCellViewModel = cellVM
               
               return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath)

    }
    
    
}
//extension CategoryViewController{
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if let vc = segue.destination as? PhotoDetailViewController,
//               let product = viewModel.selectedProduct {
//               vc.imageUrl = product.image_url
//           }
//    }
//}

