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
    
    
    func basketToList() -> [(item: InventoryItem, noItems: Int)] {
        
        var basketList = [(item: InventoryItem, noItems: Int)]()
        for (key, value) in appDelegate.basket.items {
            
            basketList.append((item: key, noItems: value))
        }
        
        return basketList
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.basket.items.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BasketTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BasketTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UITableViewCell.")
        }
        
        let basketItem = basketToList()[indexPath.row]
        
        cell.item = basketItem.item
        
        cell.symbolLabel.text = basketItem.item.symbol
        cell.initialValue = basketItem.noItems
        cell.stepper.value = Double(basketItem.noItems)
        cell.countLabel.text = String(basketItem.noItems)
        
        
       
        
        return cell
    }


}

