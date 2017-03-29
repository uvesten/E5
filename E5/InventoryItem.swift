//
//  InventoryItem.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation


class InventoryItem {
    
    //MARK: Properties
    
    var name: String
    var unit: String
    var currency: String
    var unitPrice: Float
    
    
    init(dict: [String:AnyObject]) {
        
        guard let name = dict["name"] as? String else {
            fatalError("Inventory is broken")
        }
        
        guard let unit = dict["unit"] as? String else {
            fatalError("Inventory is broken")
        }
        
        guard let unitPrice = dict["unitPrice"] as? Float else {
            fatalError("Inventory is broken")
        }
        
        guard let currency = dict["currency"] as? String else {
            fatalError("Inventory is broken")
        }
        
        self.name = name
        self.unit = unit
        self.unitPrice = unitPrice
        self.currency = currency
    }
        
        
    
    
    
}
