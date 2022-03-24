//
//  NetworkServiceProtocol.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/23/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation


protocol NetworkServiceProtocol {
    func fetchBrands(onSuccess: @escaping (Brands) -> Void, onError: @escaping (String) -> Void)
    func fetchProducts(onSuccess: @escaping (Products) -> Void, onError: @escaping (String) -> Void)
}
