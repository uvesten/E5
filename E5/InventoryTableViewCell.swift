//
//  InventoryTableViewCell.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
    
    
    //MARK: Callbacks
    var onAdd: (()->())?
    
    //MARK: Properties
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    // when the basket button is clicked, call the callback to add our item to the basket
    @IBAction func addToBasket(_ sender: Any) {
        onAdd?()
    }
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
