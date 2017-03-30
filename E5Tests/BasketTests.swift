//
//  BasketTests.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-30.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import XCTest
@testable import E5


class BasketTests: XCTestCase {
    
    var item1: InventoryItem!
    var item2: InventoryItem!
   
    
    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let anItemDict1 = ["name": "test", "unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        let anItemDict2 = ["name": "test2", "unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        self.item1 = try! InventoryItem(dict: anItemDict1)
        self.item2 = try! InventoryItem(dict: anItemDict2)
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddOneItem() {
        let basket = Basket()
        
        basket.addItem(item: self.item1)
        
        XCTAssertTrue(basket.items.count == 1)
        XCTAssertTrue(basket.items[item1] == 1)
        
    }
    
    func testAddTwoSameItems() {
        let basket = Basket()
        
        basket.addItem(item: self.item1)
        basket.addItem(item: self.item1)
        
        XCTAssertTrue(basket.items.count == 1)
        XCTAssertTrue(basket.items[item1] == 2)
        
    }
    
    func testAddTwoDifferentItems() {
        let basket = Basket()
        
        basket.addItem(item: self.item1)
        basket.addItem(item: self.item2)
        
        XCTAssertTrue(basket.items.count == 2)
        XCTAssertTrue(basket.items[item1] == 1)
        XCTAssertTrue(basket.items[item2] == 1)

        
    }
    
    
}
