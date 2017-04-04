//
//  Basket.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import Foundation

enum BasketError: Error {
    case removeUnexisting(message: String)
}


/// Our main shopping basket class
/// Holds inventoryItems and their associated counts
class Basket {
    
    var items = [InventoryItem:Int]()
    private var arrayNeedsRefresh = false
    private var internalItemArray = [(item: InventoryItem, noItems: Int)]()
    
    /// Add an item to our shopping basket
    ///
    /// - Parameter item: An InventoryItem
    /// - Returns: The number of that item in the basket
    func addItem(item: InventoryItem) -> Int {
        
        arrayNeedsRefresh = true
        
        guard items[item] != nil else {
            items[item] = 1
            return 1
        }
        
        items[item]? += 1
        
        
        return items[item]!
        
    }
    
    /// Remove an item from the basket
    ///
    /// - Parameter item: an InventoryItem
    /// - Returns: the number of that item after removal
    /// - Throws: BasketError.removeUnexisting on trying to remove an item not in basket
    func removeItem(item: InventoryItem) throws -> Int {
        
        guard items[item] != nil else {
            throw BasketError.removeUnexisting(message: "Tried to remove unexisting item " + item.name + " from basket.")
        }
        arrayNeedsRefresh = true
        
        items[item]? -= 1
        let itemCount = items[item]!
        
        if (itemCount == 0) {
            items.removeValue(forKey: item)
        }
        
        return itemCount
        
    }
    
    var sortedItemArray: [(item: InventoryItem, noItems: Int)] {
        get {
            if arrayNeedsRefresh {
                internalItemArray = []
                let sortedKeys = items.keys.sorted()
                for key in sortedKeys {
                    internalItemArray.append((item: key, noItems: items[key]!))
                }
            }
            arrayNeedsRefresh = false
            return internalItemArray
        }
    }
    
    var basePrice: Double {
        get {
            var price = Double(0)
            for (item, count) in items {
                price += (item.unitPrice * Double(count))
                
            }
            return price
        }
    }
    
    
    func clear() {
        arrayNeedsRefresh = true
        items = [:]
    }
    
    var empty: Bool {
        get {
            if self.items.count == 0 {
                return true
            }
            return false
        }
    }
    
    
    
    
    
    
}
