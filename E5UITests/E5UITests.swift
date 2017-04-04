//
//  E5UITests.swift
//  E5UITests
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import XCTest

class E5UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddOneEachIncrementCheckout() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        // put one item each in the basket
        tablesQuery.cells.containing(.staticText, identifier:"🍅").buttons["🛒"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥚").buttons["🛒"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥛").buttons["🛒"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥜").buttons["🛒"].tap()
        
        // switch to shopping basket view
        app.tabBars.buttons["Shopping Basket"].tap()
        // verify that all is in the basket
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥚").staticTexts["1"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🍅").staticTexts["1"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥛").staticTexts["1"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥜").staticTexts["1"].value)

        //increment all
        tablesQuery.cells.containing(.staticText, identifier:"🥚").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥜").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🍅").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥛").buttons["Increment"].tap()
        // verify that all have been incremented
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥚").staticTexts["2"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🍅").staticTexts["2"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥛").staticTexts["2"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥜").staticTexts["2"].value)
        
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥚").staticTexts["2"].value)
        
        XCTAssert(tablesQuery.cells.containing(.staticText, identifier:"🥚").count == 1)
        
        // decrement an item in the list until it disappears
        tablesQuery.cells.containing(.staticText, identifier:"🥚").buttons["Decrement"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥚").buttons["Decrement"].tap()
        
        XCTAssert(tablesQuery.cells.containing(.staticText, identifier:"🥚").count == 0)
        
        tablesQuery.cells.containing(.staticText, identifier:"🥜").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🍅").buttons["Increment"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🥛").buttons["Increment"].tap()
        
        // now we have three of each
        
        let checkoutButton = app.buttons["Checkout"]
        checkoutButton.tap()
        
        // now we're on the checkout screen
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        // we should be back at shopping basket, and the basket should not be empty
        XCTAssertFalse(app.tables["Empty list"].exists)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🍅").staticTexts["3"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥛").staticTexts["3"].value)
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🥜").staticTexts["3"].value)
        
        // checkout again (for real)
        checkoutButton.tap()

        
        
        // this should be the price (unchanged)
        
        let defaultPrice = "8.94 USD"
        XCTAssertTrue(app.staticTexts[defaultPrice].exists)
        
        // make sure we can get another price
        app.pickerWheels["USD"].swipeUp()
        XCTAssertFalse(app.staticTexts[defaultPrice].exists)
        
        checkoutButton.tap()
        
        // basket should be empty
        XCTAssertTrue(app.tables["Empty list"].exists)
    }
    
    func testCheckoutButtonEnabling() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        // switch to basket view, verify checkout is disabled
        app.tabBars.buttons["Shopping Basket"].tap()
        let checkoutButton = app.buttons["Checkout"]
    
        XCTAssertFalse(checkoutButton.isEnabled)
        
        //switch back to inventory, put one item in
        app.tabBars.buttons["Inventory"].tap()
        tablesQuery.cells.containing(.staticText, identifier:"🍅").buttons["🛒"].tap()

        
        // go back to shopping cart
        app.tabBars.buttons["Shopping Basket"].tap()
        XCTAssertNotNil(tablesQuery.cells.containing(.staticText, identifier:"🍅").staticTexts["1"].value)
        XCTAssertTrue(checkoutButton.isEnabled)
        tablesQuery.cells.containing(.staticText, identifier:"🍅").buttons["Decrement"].tap()
        XCTAssert(tablesQuery.cells.containing(.staticText, identifier:"🍅").count == 0)
        XCTAssertFalse(checkoutButton.isEnabled)

    }
}
