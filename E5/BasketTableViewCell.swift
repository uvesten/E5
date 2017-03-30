//
//  BasketTableViewCell.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-30.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    var initialValue: Int!
    @IBAction func stepperChanged(_ sender: Any) {
        
        guard let myStepper = sender as? UIStepper else {
            return
        }
        
        if myStepper.value < Double(initialValue) {
            print("decrement")
        } else {
            print("increment")
        }
        
        self.countLabel.text = String(Int(myStepper.value))
        
        
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
