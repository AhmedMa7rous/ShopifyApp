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
      func fetchProductsditails(productsID:String,complation:@escaping(Result<Products?,Error>)->Void)
    
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

        enum ApiError : Error {
            case fetchBrandFail
        }
        
        // Make request for all  Api URl
        private func createRequest(url:URL?,completion:(URLRequest)->Void){
            
            guard let url = url else {
                return
            }
            let request = URLRequest(url: url)
            completion(request)
        }
        
        public func getAllBrands(completion: @escaping(Result<[Smart_collections]?,Error>)->Void){
            createRequest(url:URL(string:UrlConstants.categoryUrl)) { request in
                
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    
                    guard let data = data , error == nil else {
                        completion(.failure(ApiError.fetchBrandFail))
                        return
                    }
                    do{
    //                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    //                    print(result)
                        let result = try JSONDecoder().decode(SmartCollectionsKey.self, from: data)
                        completion(.success(result.smart_collections))
                        
                    }catch{
                        completion(.failure(ApiError.fetchBrandFail))
                    }
                }
                
                task.resume()
            }
            
        }

    func fetchProductsditails(productsID:String,complation:@escaping(Result<Products?,Error>)->Void){
        guard let url = URL(string: (spoidyfiURL.productUrl.replacingOccurrences(of: ".json", with: ("/" + productsID+".json")))) else {
                return
            }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, _, erorr) in
                guard let data = data else
                {
                    print("")
                    return
            }
                do{
                    let result = try JSONDecoder().decode(Order.self, from: data)
                    complation(.success(result.products))
                }catch{
                    print("products ")
                }
            
        }
            task.resume()
    }
  

}
