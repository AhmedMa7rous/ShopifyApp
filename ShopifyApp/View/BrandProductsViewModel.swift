//
//  BrandDetailsViewModel.swift
//  ShopifyApp
//
//  Created by Abdallah Ehab on 18/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation

class BrandProductsViewModel {

    //MARK: Models objects
    // to reduce Dependancy
    let apiServices : NetworkServicesProtocol
    
    init(apiServices : NetworkServicesProtocol = NetworkServices()) {
        self.apiServices = apiServices
    }
    
     var productsOfBrand = [Products]()
    
    // observer
    
    private var cellViewModel :[BrandProductCell] = [BrandProductCell]() {
        didSet{
            self.reloadTableViewclosure()
        }
    }
    
    var numberOfCell : Int {
        return cellViewModel.count
    }
    func getCellViewModel (at indexPath:IndexPath)-> BrandProductCell {
        return cellViewModel[indexPath.row]
    }
    
//    var showAlert:String?{
//        didSet{
//            self.ShowErrorAlertClousre()
//        }
//    }
    
    var reloadTableViewclosure : ()->()={}
    //var ShowErrorAlertClousre  : ()->()={}
    
    // Services Functions process
    func getProductOfBrand(collectionId:String){
        apiServices.fetchProductsCollections(collectionsID: collectionId) { result in
            switch result {
            case .success(let brandProduct):
                guard let brandProduct = brandProduct else {return}
                self.processFetchBrandProduct(productBrand: brandProduct)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func processFetchBrandProduct(productBrand:[Products]){
        self.productsOfBrand = productBrand
        var vms = [BrandProductCell]()
        for products in productBrand {
            vms.append(createViewModelCell(product: products))
        }
        self.cellViewModel = vms
    }
    
    private func createViewModelCell(product:Products)->BrandProductCell{
        return BrandProductCell(productCellImage: product.image?.src ?? "")
    }
    
    
}
