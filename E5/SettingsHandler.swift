//
//  SettingsHandler.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-31.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation

struct Settings {
    
    var apiKey: String
    var toCurrencies: [String]
    var fromCurrency: String
    
}

enum SettingsError: Error {
    case missingOrInvalidSettingsEntry(message: String)
    case missingSettingsFile(message:String)
}

class SettingsHandler {
    
    class func parseSettings() throws -> Settings {
        if let path = Bundle.main.path(forResource: "Settings", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            // use swift dictionary as normal
            
            guard let apiKey = dict["CURRENCYLAYER_API_KEY"] as? String else {
                throw SettingsError.missingOrInvalidSettingsEntry(message: "Settings item missing or invalid \"CURRENCYLAYER_API_KEY\"")
            }
            
            guard let toCurrencies = dict["CURRENCYLAYER_TO"] as? [String] else {
                throw SettingsError.missingOrInvalidSettingsEntry(message: "Settings item missing or invalid \"CURRENCYLAYER_TO\"")
            }

            guard let fromCurrency = dict["CURRENCYLAYER_FROM"] as? String else {
                throw SettingsError.missingOrInvalidSettingsEntry(message: "Settings item missing or invalid \"CURRENCYLAYER_FROM\"")
            }

            return Settings(apiKey: apiKey, toCurrencies: toCurrencies, fromCurrency: fromCurrency)
        } else {
            throw SettingsError.missingSettingsFile(message: "The settings file Settings.plist is missing")
        }
    }
    
}
