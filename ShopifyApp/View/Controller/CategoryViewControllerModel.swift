//
//  CategoryViewControllerModel.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/15/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
class CategoryViewControllerModel{
    
    let apiService: NetworkServicesProtocol
    
    init( apiService: NetworkServicesProtocol = NetworkServices()) {
        self.apiService = apiService
    }
    
     var products : [Products] = [Products]()
    
     var cellViewModels: [ProductsCellModel] = [ProductsCellModel]() {
           didSet {
               self.reloadTableViewClosure?()
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
                    self.processFetchedProduct(products: products)
                   // self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func fetchProductAPIWithIB(collection_id : String) {
        apiService.fetchProductsCollections(collectionsID: collection_id) {  result in
            switch result
            {
            case .success(let products):
                guard let products = products else {return}
                    self.processFetchedProduct(products: products)
                                        // self.collectionView.reloadData()
            
            case .failure(let error):
                print(error)
                }
        }
        
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ProductsCellModel {
        return cellViewModels[indexPath.row]
    }

    func createCellViewModel( product: Products ) -> ProductsCellModel {

          //Wrap a description
         

        return ProductsCellModel( imageUrl: (product.image?.src)!,
                                  titleText: product.title!
      )
    }


      private func processFetchedProduct( products: [Products] ) {
          self.products = products // Cache
          var vms = [ProductsCellModel]()
          for product in products {
              vms.append( createCellViewModel(product: product) )
          }
          self.cellViewModels = vms
      }
}


extension CategoryViewControllerModel {
    func userPressed( at indexPath: IndexPath ){
        let product = self.products[indexPath.row]
            self.selectedProduct = product


        
    }
}
