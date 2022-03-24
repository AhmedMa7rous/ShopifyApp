//
//  BrandProductsViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 16/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class BrandProductsViewController: UIViewController {

    let viewModel = BrandProductsViewModel()
    var selectedProduct:String?
    var selectedProductForSegue:Products?
    let indicator = UIActivityIndicatorView(style: .large)
    /*============================================*/
        //MARK: Outlet Connections
    
    @IBOutlet weak var brandProducts: UICollectionView!
    var BrandName :String?
    
    
    /*============================================*/
       
    override func viewDidLoad() {
        super.viewDidLoad()
        brandProducts.register(UINib(nibName: "BrandProductsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "brandProductsCell")
        self.initVM()
        self.networkIndicator()
    }
    
    func initVM(){
        viewModel.reloadTableViewclosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.brandProducts.reloadData()
                self?.indicator.stopAnimating()
            }
        }
        if let BrandName = BrandName {
            viewModel.getProductOfBrand(collectionId: BrandName)

        }
    }
    func networkIndicator()
    {
    indicator.center = self.view.center
    self.view.addSubview(indicator)
    indicator.startAnimating()
    }
    

}
extension BrandProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.brandProducts
            {
            return  viewModel.numberOfCell
            }
            else{return 0}
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.brandProducts
            {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandProductsCell", for: indexPath) as! BrandProductsCollectionViewCell
                let cellVM = viewModel.getCellViewModel( at: indexPath )
                self.navigationItem.title = viewModel.productsOfBrand[0].vendor
                cell.productLabel.text = viewModel.productsOfBrand[indexPath.row].title
                cell.productPrice.text = viewModel.productsOfBrand[indexPath.row].variants![0].price! + " £"
                cell.BrandProductCell = cellVM
                cell.layer.borderWidth = 1
                cell.layer.masksToBounds = false
                cell.layer.borderColor = UIColor.black.cgColor
                
                    return cell
            }
            else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandProductsCell", for: indexPath) as! BrandProductsCollectionViewCell
                    return cell
                }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (brandProducts.bounds.width)/2.4, height: (brandProducts.bounds.height)/2.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0 , left: 20, bottom: 0, right: 30)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = viewModel.productsOfBrand[indexPath.row].title
        selectedProductForSegue = viewModel.productsOfBrand[indexPath.row]
        performSegue(withIdentifier: "showProductDetailsFromBrands", sender: selectedProductForSegue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    if segue.identifier == "showProductDetailsFromBrands"
    {
        let obj = segue.destination as! ProductDetailsViewController
        obj.productName = selectedProduct
        obj.product4Segue = selectedProductForSegue
       
    }
    }
    
}
