//
//  InventoryTableViewController.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

class InventoryTableViewController: UITableViewController {

    // holds our inventory. Set up in viewDidLoad
    var inventoryArray = [InventoryItem]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = false

        if let path = Bundle.main.path(forResource: "Inventory", ofType: "plist"), let arr = NSArray(contentsOfFile: path) as? [[String: Any]] {
            // use swift dictionary as normal
            
            for item in arr {
                do {
                    try inventoryArray.append(InventoryItem(dict:item))
                } catch InventoryError.invalidInventoryItem(let message) {
                    fatalError(message)
                } catch {
                    fatalError("Unknown error parsing inventory")
                }
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.inventoryArray.count
    }

    
    
    /// Return a view cell and set up a callback that adds things to basket
    ///
    /// - Parameters:
    ///   - tableView: our tableView
    ///   - indexPath: the indexPath
    /// - Returns: an InventoryTableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "InventoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InventoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of InventoryTableViewCell.")
        }
        
        let item = self.inventoryArray[indexPath.row]
        
        /// A callback function that adds the cell's 
        /// item to the basket
        func onAdd() {
            _ = appDelegate.basket.addItem(item: item)
        }
        
        cell.symbolLabel.text = item.symbol
        cell.mainLabel.text = "One " + item.unit + " of " + item.name
        cell.onAdd = onAdd
        
        return cell
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
