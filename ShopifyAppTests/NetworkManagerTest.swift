//
//  NetworkManagerTest.swift
//  ShopifyAppTests
//
//  Created by Abdallah Ehab on 23/03/2022.
//  Copyright © 2022 Ma7rous. All rights reserved.
//

import XCTest
@testable import ShopifyApp
class NetworkManagerTest: XCTestCase {

    let networkManager = NetworkServices()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllBrandsFromAPi(){
        let expectation = expectation(description: "waiting for Api response")
        
        networkManager.getAllBrands { result in
            switch result{
            case .failure( _ ):
               XCTFail()
            case .success(let brands):
              // XCTAssertNotNil(brands)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchProductsCollections(){
        let expectation = expectation(description: "waiting for Api response")
        
        networkManager.fetchProductsCollections(collectionsID: "272069099567"){ result in
            switch result{
            case .failure( _ ):
               XCTFail()
            case .success(let product):
              // XCTAssertNotNil(product)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
                                                
    func testfetchProductsditails(){
        let expectation = expectation(description: "waiting for Api response")
        
        networkManager.fetchProductsditails(productsID: "") { result  in
            switch result{
            case .failure( _ ):
               XCTFail()
            case .success(let productDetail):
              // XCTAssertNotNil(productDetail)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    

}
