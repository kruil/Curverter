//
//  Data.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation
import SwiftyJSON



final class CurrencyRates: NSObject, NSCoding {
    
    private typealias `Self` = CurrencyRates
    
    //MARK: - Properties
    private static var updateInterval:Double = 60 // in seconds
    private static var currencies = [Currency]()
    private static var timer = Timer()
    
    //MARK: - initializators
    override init(){
        super.init()
        if Self.currencies.count == 0 { Self.setToDefaultRates() }
        Self.startUpdating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let o = aDecoder.decodeObject(forKey: "currencies") as? [Currency] {Self.currencies = o}
        Self.startUpdating()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Self.currencies, forKey: "currencies")
    }
    
    //MARK: - public methods
    static func convert(amount:Double, from:Currency, to:Currency) -> Double {
        if (from == to) {return amount;}
        let result = Double(amount) * to.rate / from.rate
        return result.roundTo(places: 2)
    }
    
    static func getCurrencyByIndex(_ i: Int) -> Currency? {
        if i > -1, i < CurrencyRates.currencies.count {
            return CurrencyRates.currencies[i]
        }
        return nil
    }
    
    static func getCurrency(code:String) -> Currency? {
        for c in currencies {
            if (c.code == code) {return c}
        }
        return nil
    }
    
    func setUpdateInteval(seconds:inout Double) {
        if seconds < 10 {
            seconds = 10
        }
        Self.updateInterval = seconds
    }
    
    static func getCurrencyPosition(currency:Currency) -> Int?{
        for (index,c) in Self.currencies.enumerated() {
            if c == currency {
                return index
            }
        }
        return nil
    }
    
    static func currencyCount() -> Int {
        return currencies.count
    }
    
    //MARK: - private methods
    private static func setToDefaultRates(){
        currencies.removeAll()
        currencies.append(Currency("SEK", "Swedish Krona", 9.64)!)
        currencies.append(Currency("RUB", "Russian ruble", 64.99)!)
        currencies.append(Currency("USD", "American dollar", 1.17)!)
        currencies.append(Currency("JPY", "Japanese yen", 132.17)!)
        currencies.append(Currency("THB", "Thai baht", 38.96)!)
        currencies.append(Currency("EUR", "Euro", 1)!)
        currencies = currencies.sorted(by: { $0.code < $1.code })
    }
    
    @objc private static func onTimerTick(){
        update()
    }
    
    static private func startUpdating() {
        Self.timer = Timer.scheduledTimer(timeInterval: Self.updateInterval, target: self, selector: #selector(Self.onTimerTick), userInfo: nil, repeats: true)
    }
    
    private static func update(){
        print("Starting to update currency rates...")
        let queue = DispatchQueue.global(qos: .default)
        queue.async{
            let jsonRates = try? String(contentsOf: URL(string: Constants.apiURL)!)
            if (jsonRates != nil){
                parseJSON(jsonRates!)
            } else {
                print("It seems you don't have Internet connection")
            }
        }
    }
    
    private static func parseJSON(_ dataString:String){
        if let dataFromString = dataString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            for c in currencies {
                if let newRate = json["rates"][c.code].double {
                    c.rate = newRate
                }
            }
            print("Currency rates was updated")
        }
    }
    
}

