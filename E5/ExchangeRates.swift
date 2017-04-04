//
//  ExchangeRates.swift
//  E5
//
//  Created by Petter Uvesten on 2017-04-01.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation



struct ExchangeRates {
    
    let rates: [(currency: String, rate: Double)]
    let updatedAt: Date
}

extension ExchangeRates {

    /// Initializer, could be made to handle 
    /// json from other sources too.
    init?(json: [String:Any], settings: Settings) {
        
        guard let timestamp = json["timestamp"] as? Int,
            let jsonQuotes = json["quotes"] as? [String:Double]
            else {
                return nil
        }
        
        
        self.updatedAt = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        var quotes = [(currency: String, rate: Double)]()
        
        // always add the from currency with a rate of 1
        quotes.append((currency: settings.fromCurrency, rate: Double(1)))
        
        for (key, val) in jsonQuotes {
            // remove from currency in the response
            let strippedKey = key.replacingOccurrences(of: settings.fromCurrency, with: "")
            quotes.append((currency: strippedKey, rate: val))
        }
        
        self.rates = quotes
    }
    
}

class ExchangeRatesHandler {
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /// Reads either the pre-populated json from the deliverable, or
    /// a previously saved json dict
    ///
    /// - Returns: a json object with the stored data
    func loadExchangeRatesJson() -> [String:Any] {
        
        // first, look for previously stored data
        let docsDir = getDocumentsDirectory()
        let fileUrl = docsDir.appendingPathComponent("storedRates.json")
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonObj = json as? [String: Any] {
                // json is a dictionary
                print("Found stored json!")
                print(jsonObj)
                return jsonObj
            }
        } catch {
            //pass
        }
        // file not found or erroneous, check delivered file
        
        guard let url = Bundle.main.url(forResource: "initialRates", withExtension: "json") else {
            fatalError("Missing delivered json rates")
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let jsonObj = json as? [String: Any] {
                print(jsonObj)
                return jsonObj
            } else {
                fatalError("No exchange rates could be found")
            }
        } catch {
            fatalError("No exchange rates could be found")
        }
        
    }
    
    func saveExchangeRatesJson(json: [String:Any]) {
        let docsDir = getDocumentsDirectory()
        let fileUrl = docsDir.appendingPathComponent("storedRates.json")

        
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            try data.write(to: fileUrl, options: Data.WritingOptions.atomic)
        } catch {
            fatalError("Could not save json data")
        }
    }
}




