//
//  InventoryItem.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation

enum InventoryError: Error {
    case invalidInventoryItem(message: String)
}

struct InventoryItem {
    
    //MARK: Properties
    
    var name: String
    var symbol: String
    var unit: String
    var currency: String
    var unitPrice: Double
    
    
    /// Initialize an InventoryItem from a dictionary
    ///
    /// - Parameter dict: {[name: String], [unit: String], 
    ///                    [unitPrice: Double], [currency: String]}
    init(dict: [String : Any]) throws {
        
        guard let symbol = dict["symbol"] as? String else {
            throw InventoryError.invalidInventoryItem(message: "Inventory item missing or invalid \"symbol\"")
        }
        
        guard let name = dict["name"] as? String else {
            throw InventoryError.invalidInventoryItem(message: "Inventory item missing or invalid \"name\"")
        }
        
        guard let unit = dict["unit"] as? String else {
            throw InventoryError.invalidInventoryItem(message: "Inventory item missing or invalid \"unit\"")
        }
        
        guard let unitPrice = dict["unitPrice"] as? Double else {
            throw InventoryError.invalidInventoryItem(message: "Inventory item missing or invalid \"unitPrice\"")        }
        
        guard let currency = dict["currency"] as? String else {
            throw InventoryError.invalidInventoryItem(message: "Inventory item missing or invalid \"currency\"")
        }
        
        self.symbol = symbol
        self.name = name
        self.unit = unit
        self.unitPrice = unitPrice
        self.currency = currency
    }
        
        
    
    
    
}

extension InventoryItem: CustomStringConvertible {
    var description: String {
        return name
    }
}

extension InventoryItem: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
    
    static func == (lhs: InventoryItem, rhs: InventoryItem) -> Bool {
        return lhs.name == rhs.name
    }
}
