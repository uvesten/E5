//
//  CurrencylayerClient.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-31.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation
import Alamofire

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
    func getExchangeRates(completionHandler: ((Any?) -> ())?) {
        
        let parameters = ["access_key": settings.apiKey,
                          "source": settings.fromCurrency,
                          "currencies": settings.toCurrencies.joined(separator: ","),
                          "format": 1] as [String : Any]
        
        Alamofire.request("http://apilayer.net/api/live", parameters: parameters).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value  {
                completionHandler?(json)
            } else {
                completionHandler?(nil)
            }
            
            
            
        }
        
    }
    
    
}
