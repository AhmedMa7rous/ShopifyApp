//
//  NetworkService.swift
//  ShopifyApp
//
//  Created by Ahmed Mostafa on 14/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
<<<<<<< HEAD

class NetworkService {
    
    
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
    
    
    
}
=======
>>>>>>> parent of ead8ccf (Merge pull request #1 from ma7ros/Osama)
