//
//  ExchangeRatesHandler.swift
//  E5
//
//  Created by Petter Uvesten on 2017-04-04.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation

enum ExchangeRatesHandlerError: Error {
    case couldNotRead(message:String)
    case couldNotWrite(message:String)
}

class ExchangeRatesHandler {
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /// Reads either the pre-populated json from the deliverable, or
    /// a previously saved json dict
    /// - Parameters:
    ///   - deliveredFileName: the seed file delivered in the apps resource bundle
    ///   - cachedFileName: the cache file name used for caching json data
    /// - Returns: a json object with the stored data
    func loadExchangeRatesJson(seedFileName: String, cacheFileName: String) throws -> [String:Any] {
        
        // first, look for previously stored data
        let docsDir = getDocumentsDirectory()
        let fileUrl = docsDir.appendingPathComponent(cacheFileName)
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonObj = json as? [String: Any] {
                // json is a dictionary
                return jsonObj
            }
        } catch {
            //pass
        }
        // file not found or erroneous, check delivered file
        guard let url = Bundle.main.url(forResource: seedFileName, withExtension: nil) else {
            throw ExchangeRatesHandlerError.couldNotRead(message: "Missing delivered json rates")
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonObj = json as? [String: Any] {
                return jsonObj
            } else {
                throw ExchangeRatesHandlerError.couldNotRead(message: "No exchange rates could be found")
            }
        } catch {
            throw ExchangeRatesHandlerError.couldNotRead(message: "No exchange rates could be found")
        }
        
    }
    
    /// Save json to a cache file, for later reading
    ///
    /// - Parameters:
    ///   - json: [String:Any] containing a valid JSON object
    ///   - cacheFileName: the cache file name used for caching json data
    func saveExchangeRatesJson(json: [String:Any], cacheFileName: String) throws {
        let docsDir = getDocumentsDirectory()
        let fileUrl = docsDir.appendingPathComponent(cacheFileName)
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            try data.write(to: fileUrl, options: Data.WritingOptions.atomic)
        } catch {
            throw ExchangeRatesHandlerError.couldNotWrite(message: "Could not save json data")
        }
    }
}
