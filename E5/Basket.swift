//
//  Basket.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation


/// Our main shopping basket class
/// Holds inventoryItems and their associated counts
class Basket {
    
    var items = [InventoryItem:Int]()
    
    
    /// Add an item to our shopping basket
    ///
    /// - Parameter item: An InventoryItem
    func addItem(item: InventoryItem) {
        
        guard items[item] != nil else {
            items[item] = 1
            return
        }
        
        items[item]? += 1
        
        
        
    }
    
    
}
