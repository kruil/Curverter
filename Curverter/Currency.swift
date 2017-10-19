//
//  CurrencyRate.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation


class Currency: NSObject, NSCoding{
    var code = ""
    var name = ""
    var rate:Double = 0

    
    
    init(_ code:String,_ name:String,_ rate:Double){
        self.code = code
        self.name = name
        self.rate = rate
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        if let o = aDecoder.decodeObject(forKey: "name") as? String {name = o}
        if let o = aDecoder.decodeObject(forKey: "code") as? String {code = o}
        rate = aDecoder.decodeDouble(forKey: "rate")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(code, forKey: "code")
        aCoder.encode(rate, forKey: "rate")
    }
}
