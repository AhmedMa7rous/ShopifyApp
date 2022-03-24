//
//  CartViewControllerModil.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/20/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
class CartViewControllerModel{
    let apiService: NetworkServicesProtocol

init( apiService: NetworkServicesProtocol = NetworkServices()) {
    self.apiService = apiService
}
    var priceOfOneOrder:Double=Double()
    var priceOfOrders:Double=0
    private var orderDitails : [OrderDitail] = [OrderDitail]()
    var productID :[String] = ["6905518063663","6905518129199","6905517801519","6905517080623"]
    
private var cellViewModels: [OrderTableViewCellModel] = [OrderTableViewCellModel]() {
    didSet {
        self.reloadTableViewClosure?()
        self.setLabalClosure?()
    }
}
    func increasOrder( at indexPath: IndexPath )   {
        orderDitails[indexPath.row].numberOfProduct+=1
        processFetchedProduct(orderDitails: orderDitails)
        
    }
    func deacreaseOrder( at indexPath: IndexPath ) {
        orderDitails[indexPath.row].numberOfProduct-=1
        if orderDitails[indexPath.row].numberOfProduct==0{
            orderDitails.remove(at: indexPath.row)
            productID.remove(at: indexPath.row)
        }
        processFetchedProduct(orderDitails: orderDitails)
    
    }
    func calcalatTodalPrice()->Double {
        priceOfOrders = 0.0
        for orderDitail in orderDitails{
            
            priceOfOneOrder = (Double(orderDitail.products?.variants?[0].price ?? "0")!*Double(orderDitail.numberOfProduct))
            priceOfOrders = priceOfOrders + priceOfOneOrder
        }
        return priceOfOrders
    }
    
   

    
var numberOfCells: Int {
    return cellViewModels.count
}

var selectedProduct: Products?
    
var reloadTableViewClosure: (()->())?
    var setLabalClosure: (()->())?
    func fetchProductAPIWithIB() {
          
        for productsID in self.productID{
            
        apiService.fetchProductsditails(productsID: productsID){  result in
            switch result
            {
            case .success(let products):
                
                self.orderDitails.append(OrderDitail.init(products: products, numberOfProduct: 1, orderTimer: 0, orderStuatus: false))
                self.processFetchedProduct(orderDitails: self.orderDitails)
            case .failure(let error):
                print(error)
                }
        }
        
    }
        self.processFetchedProduct(orderDitails: orderDitails)
    }


    
    
func getCellViewModel( at indexPath: IndexPath ) -> OrderTableViewCellModel {
    return cellViewModels[indexPath.row]
}

func createCellViewModel( orderDitail: OrderDitail ) -> OrderTableViewCellModel {

          //Wrap a description
    return OrderTableViewCellModel( imageUrl: (orderDitail.products?.image?.src) ?? "photo",
                                    titleText: (orderDitail.products?.title) ?? "Check Network" ,
                                    numberOfProuduct: String(orderDitail.numberOfProduct)
    )
}


      private func processFetchedProduct( orderDitails: [OrderDitail] ) {
          var vms = [OrderTableViewCellModel]()
          for orderDitail in orderDitails {
              vms.append( createCellViewModel(orderDitail: orderDitail) )
          }
          self.cellViewModels = vms
      }
}



