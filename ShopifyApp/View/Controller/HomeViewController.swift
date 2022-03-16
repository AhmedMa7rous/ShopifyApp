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
            }
        }
        
        viewModel.fetchBrandDatafromAPI()
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
//extension  HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource
//{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch (collectionView)
//        {
//        case saleCollectionView :
//            return 1
//        case brandsCollectionView :
//            return 1
//        default :
//            return 1
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch (collectionView)
//        {
//        case saleCollectionView :
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "salesCell", for: indexPath)
//            return cell
//        case brandsCollectionView :
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandsCell", for: indexPath)
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "saleCell", for: indexPath)
//            return cell
//        }
//    }
//
//}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
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
               
                       return brandCell
                    
                    
                default:
                  let Salecell = collectionView.dequeueReusableCell(withReuseIdentifier: "salesCell", for: indexPath) as! SalesCollectionViewCell
                    Salecell.SaleImage.image = UIImage(named: salesPhotos[indexPath.row])
                    Salecell.layer.cornerRadius = 8
                    Salecell.layer.borderColor = UIColor.label.cgColor
                    Salecell.layer.borderWidth = 1
                    return Salecell
                }
    }
    
 
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: view.frame.width, height: view.frame.height/3)
        return CGSize(width: 150, height: 150)
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ProductsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        ProductsViewController.ProductId = viewModel.productId(at: indexPath)
        navigationController?.pushViewController(ProductsViewController, animated: true)
    }
    
}
