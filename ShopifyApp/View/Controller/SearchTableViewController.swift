//
//  SearchTableViewController.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 13/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewController: UITableViewController {
    lazy var viewModel: SearchTableViewControllerModel = {
        return SearchTableViewControllerModel()
    }()
    var selectedProductForSegue:Products?
    var selectedProduct:String?
    let indicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet var SearchProduct: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        self.networkIndicator()
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.textLabel?.text=cellVM.titleText
        cell.imageView?.sd_setImage(with: URL(string: cellVM.imageUrl), completed: nil)
  
        return cell
    }
    func initVM() {
        viewModel.reloadTableViewClosure = { [weak self] () in
                   DispatchQueue.main.async {
                       self?.tableView.reloadData()
                       self!.indicator.stopAnimating()
                   }
               }
               viewModel.fetchProductAPI()
    }
    func networkIndicator()
    {
    indicator.center = self.view.center
    self.view.addSubview(indicator)
    indicator.startAnimating()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedProduct = viewModel.selectedProduct[indexPath.row].
        selectedProductForSegue = viewModel.filterdProducts[indexPath.row]
        performSegue(withIdentifier: "showProductDetailsFromSearch", sender: selectedProductForSegue)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showProductDetailsFromSearch"
    {
        let obj = segue.destination as! ProductDetailsViewController
        obj.productName = selectedProduct
        obj.product4Segue = selectedProductForSegue
       
    }
    }


}
extension SearchTableViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchedText=searchText
    }
    
}
