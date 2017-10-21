//
//  Util.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static func addDoneToTextFieldKeyboard(textField:UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: textField, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    static func inputToDouble(input:String) -> Double {
        guard !input.isEmpty else {return 0}
        var result = input
        result = result.replacingOccurrences(of: " ", with: "")
        return Double(result)!
    }
    
    static func checkForDecimalInput(input:String) -> String {
        //MARK:  Filter input from wrong characters and format it
        
        func filterWrongCharacters(text:String) -> String {
            var result = text.replacingOccurrences(of: " ", with: "")
            result = result.removeLetters()
            result = result.replacingOccurrences(of: ",", with: Constants.decimalSeparator)
            if (result.countInstances(of: Constants.decimalSeparator) > 1) {
                result = String(result.dropLast())
            }
            return result
        }
        
        func AddSpacesToNumberString(text:String) -> String {
            var result = text
            var separatorPosition:Int! = result.indexOfCharacter(char: Constants.decimalSeparator.first!)
            if (separatorPosition == nil) {separatorPosition = result.characters.count}
            if (separatorPosition > 3) { result.insert(" ", at: result.index(result.startIndex, offsetBy: (separatorPosition - 3))) }
            if (separatorPosition > 6) { result.insert(" ", at: result.index(result.startIndex, offsetBy: (separatorPosition - 6))) }
            if (separatorPosition > 9) { result.insert(" ", at: result.index(result.startIndex, offsetBy: (separatorPosition - 9))) }
            return result
        }
        
        var result = filterWrongCharacters(text:input)
        if (result == Constants.decimalSeparator) {
            result = "0" + result
        }
        if (result.characters.count > 3) {
            if (result[result.characters.count - 4] == Constants.decimalSeparator) {
                result = String(result.dropLast())
            }
        }
        //add spaces:
        result = AddSpacesToNumberString(text: result)
        return result
    }
    
}












