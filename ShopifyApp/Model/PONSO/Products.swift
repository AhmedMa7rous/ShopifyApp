//
//  Products.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/21/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, bodyHTML, vendor: String?
    let productType: String?
    let variants: [Variant]?
    let images: [Image]?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case vendor
        case productType = "product_type"
        case variants, images, image
    }
}

// MARK: - Variant
struct Variant: Codable {
    let productID, id: Int?
    let title, price: String?
    let option1: String?
    let option2: String?
    let weight: Int?
    let inventoryItemID, inventoryQuantity, oldInventoryQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case id, title, price
        case option1, option2
        case weight
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
    }
}


