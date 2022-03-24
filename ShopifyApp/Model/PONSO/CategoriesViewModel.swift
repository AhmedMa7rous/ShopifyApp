//
//  CategoriesViewModel.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/22/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation



class CategoriesViewModel: NSObject {
/*====================================================*/
    //MARK: Constants & Variables
    let networkService : NetworkServiceProtocol!
    
    private var products: [Product] = [Product]()
    
    private var cellViewModels: [CategoryCellViewModel] = [CategoryCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    // Callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfItems: Int {
        return cellViewModels.count
    }
    
    var selectedProduct: Product?
    
    var reloadCollectionViewClosure: (()->())?
    
    var updateLoadingStatus: (()->())?
    
    var showAlertClosure: (()->())?
    
/*====================================================*/
    //MARK: Constructor Function
    init( networkService: NetworkServiceProtocol = NetworkService() ) {
        self.networkService = networkService
    }
/*====================================================*/
    //MARK: Services Functions
    
    // Network service Fetching data
    func initFetch() {
        state = .loading
        networkService.fetchProducts(onSuccess: { (products) in
            self.processFetchedProducts(products: products.products!)
            self.state = .populated
        }) { (errorMessage) in
            self.state = .error
            self.alertMessage = errorMessage
        }
        
    }
    
    func getCellViewModel( at indexPath: IndexPath) -> CategoryCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( product: Product) -> CategoryCellViewModel {
        var imageUrl = ""
        var productPrice = ""
        
        if let imgUrl = product.image?.src {
            imageUrl = imgUrl
        }
        
        if let price = product.variants![0].price {
            productPrice = price
        }
        return CategoryCellViewModel(imageUrl: imageUrl, price: productPrice)
    }
    
    private func processFetchedProducts(products: [Product]){
        self.products = products
        var vms = [CategoryCellViewModel]()
        for product in products {
            vms.append(createCellViewModel(product: product))
        }
        self.cellViewModels = vms
    }
}
