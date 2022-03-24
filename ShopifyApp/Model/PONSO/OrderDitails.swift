//
//  OrderDitails.swift
//  ShopifyApp
//
//  Created by ahmed osama on 3/19/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation
struct OrderDitail:Codable {
    var products:Products?
    var numberOfProduct:Int=1
    var orderTimer:Int?
    let orderStuatus:Bool?
    
}
