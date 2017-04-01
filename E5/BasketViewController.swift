//
//  SecondViewController.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var basketTableView: UITableView!
    
  let appDelegate = UIApplication.shared.delegate as! AppDelegate


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
    
    override func viewDidAppear(_ animated:Bool) {
        self.basketTableView.reloadData()
    }


    

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    // MARK: - Table view data source
    

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.basket.sortedItemArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BasketTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BasketTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UITableViewCell.")
        }
        
        let basketItem = appDelegate.basket.sortedItemArray[indexPath.row]
        
        cell.item = basketItem.item
        
        func addOrRemoveInBasket(operation: BasketManipulation) {
            
            switch operation {
            case BasketManipulation.add:
                _ = self.appDelegate.basket.addItem(item: basketItem.item)
            case BasketManipulation.remove:
                
                do {
                    let newCount = try self.appDelegate.basket.removeItem(item: basketItem.item)
                    if (newCount == 0) {
                        self.basketTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        self.basketTableView.reloadData()
                    }
                } catch {
                    fatalError("Basket counting is off")
                }
            }
      
        }
        
        cell.symbolLabel.text = basketItem.item.symbol
        cell.itemCount = basketItem.noItems
        cell.stepper.value = Double(basketItem.noItems)
        cell.countLabel.text = String(basketItem.noItems)
        cell.addOrRemoveInBasket = addOrRemoveInBasket(operation:)
        
        
        
       
        
        return cell
    }


}

