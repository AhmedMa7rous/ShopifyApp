//
//  Brands.swift
//  ShopifyApp
//
//  Created by Ma7rous on 3/21/22.
//  Copyright © 2022 Ma7rous. All rights reserved.
//
import Foundation

// MARK: - Brands
struct Brands: Codable {
    let smartCollections: [SmartCollection]?

    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    let id: Int?
    let title: String?
    let bodyHTML: String?
    let sortOrder: SortOrder?
    let disjunctive: Bool?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case sortOrder = "sort_order"
        case disjunctive
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let src: String?
}



enum SortOrder: String, Codable {
    case bestSelling = "best-selling"
}



