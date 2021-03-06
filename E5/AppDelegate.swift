//
//  AppDelegate.swift
//  E5
//
//  Created by Petter Uvesten on 2017-03-29.
//  Copyright © 2017 Everichon AB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var basket: Basket!
    var settings: Settings!
    var rates: ExchangeRates!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Read in our settings file. If missing or erroneous, die.
        
        do {
            try self.settings = SettingsHandler.parseSettings()
        } catch SettingsError.missingOrInvalidSettingsEntry(let message){
            fatalError(message)
        } catch SettingsError.missingSettingsFile(let message){
            fatalError(message)
        } catch {
            fatalError()
        }
        
        // load stored json rates
        let erh = ExchangeRatesHandler()
        do {
            let storedJson = try erh.loadExchangeRatesJson(seedFileName: self.settings.jsonSeedFilename,
                                                       cacheFileName: self.settings.jsonCacheFilename)
            guard let exchangeRates = ExchangeRates(json: storedJson, settings: self.settings) else {
                fatalError("No valid saved json results")
            }
            self.rates = exchangeRates
            
        } catch ExchangeRatesHandlerError.couldNotRead(let message){
            fatalError(message)
        } catch {
            fatalError("Unknown error reading json data from storage")
        }
        
            
        
        
        // if needed, update exchange rates
        optionallyUpdateExchangeRate()
        
        // Set up the app's shopping basket
        self.basket = Basket()
        
        return true
        
    }
    
    func receiveExchangeRates(ratesFromService: [String: Any]?) {
        
        guard let rates = ratesFromService else {
            return
        }
        
        guard let exchangeRates = ExchangeRates(json: rates, settings: self.settings) else {
            return
        }
        self.rates = exchangeRates
        let erh = ExchangeRatesHandler()
        
        do {
            try erh.saveExchangeRatesJson(json: ratesFromService!, cacheFileName: self.settings.jsonCacheFilename)
        } catch ExchangeRatesHandlerError.couldNotWrite(let message) {
            debugPrint(message)
        } catch {
            debugPrint("Error when storing json cache")
        }
        
    }
    
    
    /// Update exchange rate if old data is more than one hour old
    func optionallyUpdateExchangeRate() {
        let now = Date.init()
        if (now > self.rates.updatedAt.addingTimeInterval(TimeInterval(3600))) {
            print("Updating data")
            let client = CurrencyLayerClient(settings: self.settings)
            client.getExchangeRates(completionHandler: receiveExchangeRates)
        }
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // if needed, update exchange rates
        optionallyUpdateExchangeRate()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

