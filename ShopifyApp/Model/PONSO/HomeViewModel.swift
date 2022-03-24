//
//  HomeViewModel.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/21/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation

class HomeViewModel: NSObject {
/*====================================================*/
    //MARK: Constants & Variables
    let networkService : NetworkServiceProtocol!
    
    private var brands: [SmartCollection] = [SmartCollection]()
    
    private var cellViewModels: [HomeCellViewModel] = [HomeCellViewModel]() {
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
    
    var selectedBrand: SmartCollection?
    
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
    func initFetch() {
        state = .loading
        networkService.fetchBrands(onSuccess: { (brands) in
            self.processFetchedBrands(brands: brands.smartCollections!)
            self.state = .populated
        }) { (errorMessage) in
            self.state = .error
            self.alertMessage = errorMessage
        }
        
    }
    
    // Network service Fetching data
    func getCellViewModel( at indexPath: IndexPath) -> HomeCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( brand: SmartCollection) -> HomeCellViewModel {
        var imageUrl = ""
        var titleText = ""
        
        if let imgUrl = brand.image?.src {
            imageUrl = imgUrl
        }
        
        if let title = brand.title {
            titleText = title
        }
        return HomeCellViewModel(imageUrl: imageUrl, titleText: titleText)
    }
    
    private func processFetchedBrands(brands: [SmartCollection]){
        self.brands = brands
        var vms = [HomeCellViewModel]()
        for brand in brands {
            vms.append(createCellViewModel(brand: brand))
        }
        self.cellViewModels = vms
    }
}


