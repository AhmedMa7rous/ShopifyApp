//
//  Order.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/20/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
struct Order:Codable{
let products : Products?
    enum CodingKeys: String, CodingKey {

        case products = "product"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent(Products.self, forKey: .products)
    }
}
