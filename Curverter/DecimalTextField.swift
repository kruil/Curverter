//
//  DecimalTextView.swift
//  Curverter
//
//  Created by Илья Крупко on 22.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import Foundation
import UIKit

class DecimalTextField: UITextField {
    
    var amount:Double {
        set (value) {
            text = checkForDecimalInput(input: String(value))
        }
        get{
            return inputToDouble(input: text!) ?? 0.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(DecimalTextField.formatText), for: .editingChanged)
        keyboardType = .decimalPad
        addDoneKeyToKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(DecimalTextField.formatText), for: .editingChanged)
        keyboardType = .decimalPad
        addDoneKeyToKeyboard()
    }
    
    private func addDoneKeyToKeyboard(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    @objc func formatText() {
        if let text = text {
            self.text = checkForDecimalInput(input: text)
        }
    }
    
    private func inputToDouble(input:String) -> Double? {
        var result = input
        result = result.replacingOccurrences(of: " ", with: "")
        return Double(result)
    }
    
    private func checkForDecimalInput(input:String) -> String {
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
        
        func checkEnd(text:String) -> String {
            var result:String = text
            if result.indexOfCharacter(char: ".") == result.characters.count - 2 {
                result.append("0")
            }
            result = result.replacingOccurrences(of: ".00", with: "")
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
        result = AddSpacesToNumberString(text: result)
        if self.isEditing == false {
            result = checkEnd(text: result)
        }
        return result
    }
}






