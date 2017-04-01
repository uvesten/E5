//
//  BasketTableViewCell.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-30.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

enum BasketManipulation {
    case remove
    case add
}

class BasketTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    var itemCount: Int!
    //MARK: Callbacks
    var addOrRemoveInBasket: ((BasketManipulation) -> ())?
    
    @IBAction func stepperChanged(_ sender: Any) {
        
        guard let myStepper = sender as? UIStepper else {
            return
        }
        
        let oldValue = itemCount!
        itemCount = Int(myStepper.value)
        self.countLabel.text = String(itemCount)
        
        if myStepper.value < Double(oldValue) {
            addOrRemoveInBasket?(BasketManipulation.remove)
        } else {
            addOrRemoveInBasket?(BasketManipulation.add)
        }
        
        
    }
    
    var item: InventoryItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
