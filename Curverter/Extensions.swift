//
//  Extensions.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation


extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



extension String {
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[Range(start ..< end)])
    }
    
    
    func removeLetters() -> String {
        return self.components(separatedBy: CharacterSet.letters).joined()
    }
    
    
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var searchRange: Range<String.Index>?
        var count = 0
        while let foundRange = range(of: stringToFind, options: .diacriticInsensitive, range: searchRange) {
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
            count += 1
        }
        return count
    }
    
    
    func indexOfCharacter(char: Character) -> Int? {
        guard let index = characters.index(of: char) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
