//
//  AppDelegate.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        loadData()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        loadData()
    }
    
    //MARK: - Serialization methods
    var dataSavingFilePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Curvertor").path)
    }
    
    func loadData(){
        if let _ = NSKeyedUnarchiver.unarchiveObject(withFile: dataSavingFilePath) as? CurrencyRates {
            print("loaded")
        } else {
            let _ = CurrencyRates()
            print("CurrencyRates was set to default ")
        }
    }
    
    func saveData(){
        NSKeyedArchiver.archiveRootObject(CurrencyRates(), toFile: dataSavingFilePath)
    }
    
}

