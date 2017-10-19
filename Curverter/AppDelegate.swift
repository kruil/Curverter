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

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data1").path)
    }
    
    func loadData(){
        print("Loading data...")
        if let _ = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? CurrencyRates {
            print("loaded")
        } else {
            CurrencyRates.setToDefault()
            print("setToDefault")
        }
        print(CurrencyRates.currencies.count)
        print("end of loading.")
    }
    
    func saveData(){
        NSKeyedArchiver.archiveRootObject(CurrencyRates(), toFile: filePath)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        loadData()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

