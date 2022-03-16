//
//  HomeViewModel.swift
//  ShopifyApp
//
//  Created by Abdallah Ehab on 14/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation

class HomeViewModel {
    
//    override init() {
//        super.init()
//        self.fetchBrandDatafromAPI()
//    }
    
    //objects from models
    let networkService = NetworkService()
    private var brands = [Smart_collections]()
    
    
    // reload TableView
    // observer var from type custom cell view model
    private var cellViewModel : [BrandViewModelCell] = [BrandViewModelCell](){
        didSet {
            self.reloadTableViewClosure()
        }
    }
    
    // bind to show error in alert
    var alertMessage: String? {
        didSet {
           self.showErrorAlertClosure()
        }
    }
    
    
    // number Of row
    var numberOfCells: Int {
        return cellViewModel.count
    }
    
    // index of cell
    func getCellViewModel( at indexPath: IndexPath ) -> BrandViewModelCell {
        return cellViewModel[indexPath.row]
    }
   
    
    // binding to View
    var showErrorAlertClosure : (()->()) = {}
    var reloadTableViewClosure : (()->()) = {}
    
    
    // api service function
    func fetchBrandDatafromAPI(){
        networkService.getAllBrands { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result{
            case .success(let brand):
                guard let brand = brand else{ return}
                self.processFetchedBrand(brands: brand)
             case .failure(let error):
                self.alertMessage = error.localizedDescription
            }
        }
    }
    
    
    private func processFetchedBrand (brands:[Smart_collections]){
        self.brands = brands
        var vms = [BrandViewModelCell]()
        for brand in brands {
            vms.append(createCellViewModel(brand: brand))
        }
        self.cellViewModel = vms
    }
    
    
    func createCellViewModel( brand: Smart_collections ) -> BrandViewModelCell {
    
        return BrandViewModelCell(brandImageCell: brand.image?.src ?? "",brandLabelCell: brand.title ?? "Brand Titlt ")
    }
    
    func productId( at indexPath: IndexPath )->Int{
        let brandId = self.brands[indexPath.row].id
        guard let brandId = brandId else {return 0}
        return brandId
    }
    
    
}
