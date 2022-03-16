//
//  NetworkService.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 14/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
protocol NetworkServicesProtocol {
      func fetchProducts(complation:@escaping(Result<[Products]?,Error>)->Void)
      func fetchProductsCollections(collectionsID:String,complation:@escaping(Result<[Products]?,Error>)->Void)
    
}

class NetworkServices:NetworkServicesProtocol {
    let spoidyfiURL = UrlConstants()
        func fetchProducts(complation:@escaping(Result<[Products]?,Error>)->Void){
            guard let url = URL(string: spoidyfiURL.productUrl) else {
                return
            }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, _, erorr) in
                guard let data = data else{
                    return
            }
                do{
                    let result = try JSONDecoder().decode(productsKey.self, from: data)
                    complation(.success(result.products))
                }catch{
                    print("products ")
                }
            
        }
            task.resume()
    }
    func fetchProductsCollections(collectionsID:String,complation:@escaping(Result<[Products]?,Error>)->Void){
            guard let url = URL(string: (spoidyfiURL.productUrl + "?collection_id=" + collectionsID)) else {
                return
            }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, _, erorr) in
                guard let data = data else{
                    return
            }
                do{
                    let result = try JSONDecoder().decode(productsKey.self, from: data)
                    complation(.success(result.products))
                }catch{
                    print("products ")
                }
            
        }
            task.resume()
    }
}
