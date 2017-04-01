//
//  CurrencylayerClient.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-31.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation
import Alamofire

struct ExchangeRates {
    
    let fromCurrency: String
    let rates: [String: Double]
    let updatedAt: Date
    
}

enum CurrencyLayerError: Error {
    case invalidJson
}

class CurrencyLayerClient {
    
    var settings: Settings!
    
    init(settings: Settings) {
        self.settings = settings
    }
    
    
    /// Gets exchange rates from currencylayer for the settings
    /// in settings plist.
    /// API example:
    /// http://apilayer.net/api/live
    /// ? access_key = YOUR_ACCESS_KEY
    /// & source = GBP
    /// & currencies = USD,AUD,CAD,PLN,MXN
    /// & format = 1
    /// - Parameter completionHandler: a function that does something with the returned ExchangeRates?
    func getExchangeRates(completionHandler: ((ExchangeRates?) -> ())?) {
        
        let parameters = ["access_key": settings.apiKey,
                          "source": settings.fromCurrency,
                          "currencies": settings.toCurrencies.joined(separator: ","),
                          "format": 1] as [String : Any]
        
        Alamofire.request("http://apilayer.net/api/live", parameters: parameters).responseJSON { response in
            
            if let json = response.result.value as? [String:Any] {
                if let rates = self.parseResponse(json: json) {
                    completionHandler?(rates)
                } else {
                    completionHandler?(nil)
                }
            } else {
                completionHandler?(nil)
            }
            
            
            
        }
        
    }
    
    
    private func parseResponse(json: [String:Any]) -> ExchangeRates? {
        
        guard let timestamp = json["timestamp"] as? Int,
            let jsonQuotes = json["quotes"] as? [String:Double]
            else {
                return nil
        }
        
        
        let updatedDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // remove from currency in the response
        
        var quotes = [String:Double]()
        
        for (key, val) in jsonQuotes {
            let strippedKey = key.replacingOccurrences(of: self.settings.fromCurrency, with: "")
            quotes[strippedKey] = val
        }
        
        return ExchangeRates(fromCurrency: self.settings.fromCurrency, rates: quotes, updatedAt: updatedDate)
        
    }
    
}
