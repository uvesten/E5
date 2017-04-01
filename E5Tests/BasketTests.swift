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
    var basket: Basket!
   
    
    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let anItemDict1 = ["symbol": "🥐", "name": "test", "unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        let anItemDict2 = ["symbol": "🥐", "name": "test2", "unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        self.item1 = try! InventoryItem(dict: anItemDict1)
        self.item2 = try! InventoryItem(dict: anItemDict2)
        
        basket = Basket()
                
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddOneItem() {
        
        
        XCTAssert(basket.addItem(item: self.item1) == 1)
        
        XCTAssertTrue(basket.items.count == 1)
        XCTAssertTrue(basket.items[item1] == 1)
        
        XCTAssert(basket.sortedItemArray.count == 1)
        
    }
    
    func testAddTwoSameItems() {
        let basket = Basket()
        
        XCTAssert(basket.addItem(item: self.item1) == 1)
        XCTAssert(basket.addItem(item: self.item1) == 2)
        
        XCTAssertTrue(basket.items.count == 1)
        XCTAssertTrue(basket.items[item1] == 2)
        
        XCTAssert(basket.sortedItemArray.count == 1)
        
    }
    
    func testAddTwoDifferentItems() {
        let basket = Basket()
        
        let i1count = basket.addItem(item: self.item1)
        let i2count = basket.addItem(item: self.item2)
        
        XCTAssert(i1count == 1)
        XCTAssert(i2count == 1)
        
        XCTAssertTrue(basket.items.count == 2)
        XCTAssertTrue(basket.items[item1] == 1)
        XCTAssertTrue(basket.items[item2] == 1)
        
        XCTAssert(basket.sortedItemArray.count == 2)

        
    }
    
    func testAddAndRemove() {
        let basket = Basket()
        
        XCTAssert(basket.addItem(item: self.item1) == 1)
        XCTAssert(try basket.removeItem(item: self.item1) == 0)
        
        XCTAssert(basket.sortedItemArray.count == 0)
        
        
        
        
    }
    
    func testClear() {
        let basket = Basket()
        
        _ = basket.addItem(item: self.item1)
        _ = basket.addItem(item: self.item1)
        
        XCTAssert(basket.sortedItemArray.count == 1)
        
        basket.clear()
        
        XCTAssert(basket.sortedItemArray.count == 0)
        
    }
    
    func testRemoveUnexisting() {
        let basket = Basket()
        
        XCTAssertThrowsError(try basket.removeItem(item: self.item1) == 0)
        
        
    }
    
    func testRemoveTooMany() {
        let basket = Basket()
        XCTAssert(basket.addItem(item: self.item1) == 1)
        XCTAssert(try basket.removeItem(item: self.item1) == 0)
        
        XCTAssertThrowsError(try basket.removeItem(item: self.item1) == 0)
        
    }
    
    
}
