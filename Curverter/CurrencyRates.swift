//
//  Data.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation
import SwiftyJSON



class CurrencyRates: NSObject, NSCoding {
    
    typealias `Self` = CurrencyRates
    static var currencies = [Currency]()

    
    override init(){
        if Self.currencies.count == 0 {
            Self.setToDefault()
        }
    }

    
    static func setToDefault(){
        currencies.removeAll()
        currencies.append(Currency("USD", "American dollar", 1.17))
        currencies.append(Currency("JPY", "Japanese yen", 132.17))
        currencies.append(Currency("RUB", "Russian ruble", 64.99))
        currencies.append(Currency("THB", "Thai baht", 38.96))
        currencies.append(Currency("EUR", "Euro", 1))
    }
    
    
    
    static func getCurrencyPosition(currency:Currency) -> Int?{
        for (index,c) in Self.currencies.enumerated() {
            if c == currency {
                return index
            }
        }
        return nil
    }
    
    
    
    static func update(){
        print("Starting to update currency rates...")
        let queue = DispatchQueue.global(qos: .default)
        queue.async{
            let jsonRates = try? String(contentsOf: URL(string: "http://api.fixer.io/latest")!)
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
    
    
    static func convert(amount:Double, from:String, to:String) -> Double {
        if (from == to) {return amount;}
        let result = Double(amount) * getRate(to)! / getRate(from)!
        return result.roundTo(places: 2)
    }
    
    
    
    static func getCurrencyByIndex(_ i: Int) -> Currency? {
        if i > -1, i < CurrencyRates.currencies.count {
            return CurrencyRates.currencies[i]
        }
        return nil
    }
    
    
    
    static func getRate(_ code:String) -> Double? {
        return getCurrency(code: code)?.rate
    }
    
    
    
    static func getCurrency(code:String) -> Currency? {
        for c in currencies {
            if (c.code == code) {return c}
        }
        return nil
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        if let o = aDecoder.decodeObject(forKey: "currencies") as? [Currency] {Self.currencies = o}
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Self.currencies, forKey: "currencies")
    }
    
}
