//
//  NetworkService.swift
//  ShopifyApp
//
//  Created by Ma7rous on 14/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation


class NetworkService: NetworkServiceProtocol{
/*================================================*/
    //MARK: Constants & Variables
    let session = URLSession(configuration: .default)
/*================================================*/
    //MARK: Fetch Brands Data
    func fetchBrands(onSuccess: @escaping (Brands) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string:URLs.categoryUrl)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.sync {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid Data Response!")
                    return
                }
                
                do{
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Brands.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
/*==============================================*/
    //MARK: Fetch Products Data
    func fetchProducts(onSuccess: @escaping (Products) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string:URLs.productUrl)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.sync {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid Data Response!")
                    return
                }
                
                do{
                    if response.statusCode == 200 {
                        let result = try JSONDecoder().decode(Products.self, from: data)
                        onSuccess(result)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
