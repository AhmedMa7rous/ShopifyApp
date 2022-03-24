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
    var selectedProduct:String?
    var selectedProductForSegue:Products?
    let indicator = UIActivityIndicatorView(style: .large)
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
            self.initVM()
        case 1:
            self.fetchProductsWithIB(collection_id: "269278806068")
        case 2:
            self.fetchProductsWithIB(collection_id: "269278904372")
        case 3:
            self.fetchProductsWithIB(collection_id: "269278838836")
        case 4:
            self.fetchProductsWithIB(collection_id: "268946243636")
            
        default:
            self.initVM()
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
        self.networkIndicator()
    }
    /*============================================*/
    //MARK: Services Functions
    func initVM() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async { [self] in
                       self?.productsClollectionView.reloadData()
                self!.indicator.stopAnimating()
                   }
               }
               
               viewModel.fetchProductAPI()

        
    }
    func  fetchProductsWithIB(collection_id : String){
        self.networkIndicator()
        viewModel.fetchProductAPIWithIB(collection_id: collection_id)
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productsClollectionView.reloadData()
                self!.indicator.stopAnimating()
            }
        }
        
    }
    func networkIndicator()
    {
    indicator.center = self.view.center
    self.view.addSubview(indicator)
    indicator.startAnimating()
    }
    

}


extension CategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout
{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductsCollectionViewCell
        let cellVM = viewModel.getCellViewModel( at: indexPath )
               cell.productListCellViewModel = cellVM
        cell.productPrice.text = viewModel.products[indexPath.row].variants![0].price! + " £"
        cell.updateCellUi(forCell: cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.viewModel.userPressed(at: indexPath)
        selectedProduct = viewModel.products[indexPath.row].title
        selectedProductForSegue = viewModel.products[indexPath.row]
        performSegue(withIdentifier: "showProductDetails", sender: selectedProductForSegue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  55
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 150)
    }
       
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
        cell.alpha = 1
        }
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if segue.identifier == "showProductDetails"
    {
        let obj = segue.destination as! ProductDetailsViewController
        obj.productName = selectedProduct
        obj.product4Segue = selectedProductForSegue
       
    }
    }
   
    
    
}


