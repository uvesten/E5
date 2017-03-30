//
//  InventoryItemTests.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-30.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import XCTest
@testable import E5

class InventoryItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateWithValidItemAndCompare() {
                
        let anItemDict = ["name": "test", "unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        print(anItemDict)
        
        let invItem1 = try! InventoryItem(dict: anItemDict)
        
        let invItem2 = try! InventoryItem(dict: anItemDict)

        XCTAssertTrue(invItem1 == invItem2)
        
    }
    
    
    func testAddInvalidItem1() {
        
         let anItemDict = ["unitPrice": 0.8, "unit": "bag", "currency":"USD"] as [String : Any]
        
        XCTAssertThrowsError(try InventoryItem(dict: anItemDict))
        
    }
    
    func testAddInvalidItem2() {
        
        let anItemDict = ["name": "test", "unitPrice": "0.8", "unit": "bag", "currency":"USD"] as [String : Any]
        
        XCTAssertThrowsError(try InventoryItem(dict: anItemDict))
        
    }
    
   
}
