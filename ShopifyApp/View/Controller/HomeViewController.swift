//
//  HomeViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var salesPhotos = ["sale1","sale2","sale3","sale4"]
    var viewModel = HomeViewModel()
    var SelectedBrand:String?
    let indicator = UIActivityIndicatorView(style: .large)
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
        self.networkIndicator()
        // Do any additional setup after loading the view.
              initViewModel()

    }
    
    func initViewModel(){
   
           viewModel.showErrorAlertClosure = {  [weak self] () in
               DispatchQueue.main.async {
                   if let message = self?.viewModel.alertMessage {
                       self?.showAlert( message )
                   }
               }
           }
   
           viewModel.reloadTableViewClosure = { [weak self] () in
               DispatchQueue.main.async {
                   self?.brandsCollectionView.reloadData()
                   self!.indicator.stopAnimating()
               }
           }
   
           viewModel.fetchBrandDatafromAPI()
       }
   
       func showAlert( _ message: String ) {
           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
           alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
        func networkIndicator()
        {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        }
    
    

}
/*===============================================================*/
    //MARK: CollectionView Functions
extension  HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch collectionView {
            case brandsCollectionView:
                return viewModel.numberOfCells
        default:
                return salesPhotos.count
            }
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
                    switch collectionView {
                    case brandsCollectionView:
                        let brandCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath) as! BrandsCollectionViewCell
                        let cellVM = viewModel.getCellViewModel( at: indexPath )
                        brandCell.BrandListCellViewModel = cellVM
                        brandCell.updateCellUi(forCell: brandCell)
                           return brandCell
    
    
                    default:
                      let saleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "salesCell", for: indexPath) as! SalesCollectionViewCell
                        saleCell.SaleImage.image = UIImage(named: salesPhotos[indexPath.row])
                        saleCell.updateCellUi(forCell: saleCell)
                        return saleCell
                    }
        }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case brandsCollectionView:
            let padding: CGFloat =  35
            let collectionViewSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: 180)
        default:
            let padding: CGFloat =  20
            let collectionViewWidthSize = collectionView.frame.size.width - padding
            let collectionViewHeightSize = collectionView.frame.size.height - padding
            return CGSize(width: collectionViewWidthSize, height: collectionViewHeightSize)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.2
        UIView.animate(withDuration: 0.8) {
        cell.alpha = 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandsCollectionView
        {
        SelectedBrand =  "\(viewModel.productId(at: indexPath))"
        performSegue(withIdentifier: "showCategoryProducts", sender:  self)
        }
    }
    
    
    /*===================================================*/
        //MARK: Segue Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCategoryProducts"
    {
        let obj = segue.destination as! BrandProductsViewController
        obj.BrandName = SelectedBrand
       
    }
    }
    
}
