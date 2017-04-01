//
//  CheckoutViewController.swift
//  E5
//
//  Created by Petter Uvesten on 2017-04-01.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var cancel: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func checkout(_ sender: Any) {
        self.basket.clear()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var latestUpdateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var basket: Basket!
    var exchangeRates: ExchangeRates!
    
    @IBOutlet weak var currencySelector: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showCalculatedPrice(rateItem: exchangeRates.rates[0])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        
        let dateString = dateFormatter.string(from: exchangeRates.updatedAt)
        self.latestUpdateLabel.text = "Latest rate update on " + dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCalculatedPrice(rateItem: (currency: String, rate: Double)) {
        let basePrice = basket.basePrice
        let newPrice = basePrice * rateItem.rate
        self.priceLabel.text = String(newPrice) + " " + rateItem.currency
    }
    
    //MARK: UIPickerViewDataSource
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return exchangeRates.rates.count
    }
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rate = exchangeRates.rates[row]
        
        return rate.currency
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        let rate = exchangeRates.rates[row]
        
        showCalculatedPrice(rateItem: rate)
    }
    
    

   
}
