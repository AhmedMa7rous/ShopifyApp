//
//  SearchTableViewControllerModel.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/17/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
class SearchTableViewControllerModel{
        let apiService: NetworkServicesProtocol
    
    init( apiService: NetworkServicesProtocol = NetworkServices()) {
        self.apiService = apiService
    }
     var products : [Products] = [Products]()
     var filterdProducts : [Products] = [Products]()
       
    private var cellViewModels: [ProductsCellModel] = [ProductsCellModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
       
    var searchedText : String = String(){
        didSet {
            searchProducts()
           
        }
    }
        
    var numberOfCells: Int {
        return cellViewModels.count
    }

    var selectedProduct: Products?
        
    var reloadTableViewClosure: (()->())?
        
    func fetchProductAPI() {
        apiService.fetchProducts { result in
            switch result
            {
            case .success(let products):
                DispatchQueue.main.async {
                    guard let products = products else {return}
                    self.products=products
                       // self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func searchProducts() {
        filterdProducts.removeAll()
        
        for product in products{
            if ((product.title!.localizedCaseInsensitiveContains(searchedText)) ){
                filterdProducts.append(product)
            }
        }
        self.processFetchedProduct(products: filterdProducts)
    
    }

        
        
    func getCellViewModel( at indexPath: IndexPath ) -> ProductsCellModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( product: Products ) -> ProductsCellModel {

              //Wrap a description
        return ProductsCellModel( imageUrl: (product.image?.src) ?? "photo",
                                  titleText: product.title ?? "NO Data"
        )
    }


          private func processFetchedProduct( products: [Products] ) {
              self.filterdProducts = products // Cache
              var vms = [ProductsCellModel]()
              for product in products {
                  vms.append( createCellViewModel(product: product) )
              }
              self.cellViewModels = vms
          }
    }



