//
//  CurrencyLayerTest.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-31.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import XCTest
@testable import E5

/// Tests both settings and currencylayer API. 
/// Must be run before release
class CurrencyLayerTest: XCTestCase {
    
    var settings: Settings!
    
    override func setUp() {
        super.setUp()
        // Get our settings
        do {
            try self.settings = SettingsHandler.parseSettings()
        } catch SettingsError.missingOrInvalidSettingsEntry(let message){
            fatalError(message)
        } catch SettingsError.missingSettingsFile(let message){
            fatalError(message)
        } catch {
            fatalError()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateCurrencyLayerClient() {
        
        let _ = CurrencyLayerClient(settings: self.settings)
        
    
    }
    
    func testGetRates() {
        
        let client = CurrencyLayerClient(settings: self.settings)
        
        let resultExpectation = expectation(description: "Gets a valid json result from currencylayer")
        
        client.getExchangeRates { rates in
            XCTAssertNotNil(rates, "Expected non-nil result")
            
            XCTAssert(rates?.rates[0].currency == self.settings.fromCurrency)
            XCTAssert(rates?.rates[0].rate == 1)
            resultExpectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        
    }
    
}
