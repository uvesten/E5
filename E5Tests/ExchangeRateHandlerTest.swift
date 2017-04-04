//
//  ExchangeRateHandlerTest.swift
//  E5
//
//  Created by Petter Uvesten on 2017-04-04.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import XCTest
@testable import E5

class ExchangeRateHandlerTest: XCTestCase {
    
    
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
    
 
    /// Try to read an unavailable file. 
    /// Should fail
    func testReadUnavailable() {
        
        let erh = ExchangeRatesHandler()

        XCTAssertThrowsError(try erh.loadExchangeRatesJson(seedFileName: "nothing.json", cacheFileName: "nothing.json"))

        
        
    }
    
    /// Test reading our seed file, should always work
    func testReadSeed() {
        
        let erh = ExchangeRatesHandler()
        
        do {
            let storedJson = try erh.loadExchangeRatesJson(seedFileName: self.settings.jsonSeedFilename,
                                                           cacheFileName: "doesNotExist.json")
            
            XCTAssertNotNil(storedJson)
            guard ExchangeRates(json: storedJson, settings: self.settings) != nil else {
                XCTFail("No seed json in bundle, settings wrong, or seed json on wrong format")
                return
            }
        } catch {
            XCTFail()
        }
        
    }
    
    
    /// Test writing json cache to temp file, and then reading it back
    func testCacheJson() {
        let erh = ExchangeRatesHandler()
        
        let timeStampString = String(Date.init().timeIntervalSince1970)
        let tempFileName = timeStampString + ".json"
        
        let json = ["TestJSON" : "test"] as [String:Any]
        
        do {
            try erh.saveExchangeRatesJson(json: json, cacheFileName: tempFileName)
            
            let readJson = try erh.loadExchangeRatesJson(seedFileName: self.settings.jsonSeedFilename, cacheFileName: tempFileName)
            
            let val = json["TestJSON"] as! String
            let readVal = readJson["TestJSON"] as! String
            
            XCTAssert(val == readVal)
        } catch {
            XCTFail()
        }
    }
    

}
