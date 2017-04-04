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





