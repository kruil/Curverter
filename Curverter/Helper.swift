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
    
    static func addDoneToKeyTextFieldKeyboard(textField:UITextField) {
        let keyboardToolbar = UIToolbar()
        //keyboardToolbar.barStyle = Style.uiBarStyle
        //keyboardToolbar.tintColor = Style.colorTint
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
    
    
    
    static func checkInput(input:String) -> String {
        var text:String = input.replacingOccurrences(of: " ", with:  "")
        text = text.replacingOccurrences(of: ",", with:  ".")
        let decimalSeparator = "."
        if (text.countInstances(of: decimalSeparator) > 1) {
            text = String(text.dropLast())
        }
        if (text == decimalSeparator) {
            text = "0" + text
        }
        if (text.characters.count > 3) {
            if (text[text.characters.count - 4] == decimalSeparator) {
                text = String(text.dropLast())
            }
        }
        //add spaces:
        var separatorPosition:Int! = text.indexOfCharacter(char: decimalSeparator.first!)
        if (separatorPosition == nil) {separatorPosition = text.characters.count}
        else {
            
        }
        if (separatorPosition > 3) {
            text.insert(" ", at: text.index(text.startIndex, offsetBy: (separatorPosition - 3)))
        }
        if (separatorPosition > 6) {
            text.insert(" ", at: text.index(text.startIndex, offsetBy: (separatorPosition - 6)))
        }
        if (separatorPosition > 9) {
            text.insert(" ", at: text.index(text.startIndex, offsetBy: (separatorPosition - 9)))
        }
        return text
    }
    
}
