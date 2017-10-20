//
//  ViewController.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CurrencyPickerDelegate {
    
    
    
    @IBOutlet weak var butCurrencyFrom: UIButton!
    @IBOutlet weak var butCurrencyTo: UIButton!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var textFieldTo: UITextField!
    
    var pickerButton:UIButton?
    
    var currencyFrom:Currency! {
        didSet(a) {
            butCurrencyFrom.setTitle(currencyFrom.name, for: .normal)
            onSumChanged(textFieldFrom)
        }
    }
    
    
    
    var currencyTo:Currency! {
        didSet(a) {
            butCurrencyTo.setTitle(currencyTo.name, for: .normal)
            onSumChanged(textFieldFrom)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyRates.update()
        Helper.addDoneToKeyTextFieldKeyboard(textField: textFieldFrom)
        Helper.addDoneToKeyTextFieldKeyboard(textField: textFieldTo)
        currencyFrom = CurrencyRates.currencies[0]
        currencyTo = CurrencyRates.currencies[1]
        butCurrencyFrom.setTitle(currencyFrom.name, for: .normal)
        butCurrencyTo.setTitle(currencyTo.name, for: .normal)
        textFieldFrom.text = "1"
        onSumChanged(textFieldFrom)
    }
    
    
    
    @IBAction func onSumChanged(_ sender: UITextField) {
        guard currencyFrom != nil, currencyTo != nil else { return }
        if sender == textFieldFrom {
            sender.text = Helper.checkInput(input: sender.text!)
            let amount = Helper.inputToDouble(input: sender.text!)
            let convertedAmount = CurrencyRates.convert(amount: amount, from: currencyFrom.code, to: currencyTo.code)
            textFieldTo.text = Helper.checkInput(input: String(convertedAmount))
        }
        if sender == textFieldTo {
            sender.text = Helper.checkInput(input: sender.text!)
            let amount = Helper.inputToDouble(input: sender.text!)
            let convertedAmount = CurrencyRates.convert(amount: amount, from: currencyTo.code, to: currencyFrom.code)
            textFieldFrom.text = Helper.checkInput(input: String(convertedAmount))
        }
    }
    
    
    
    @IBAction func onCurrencyTap(_ sender: UIButton) {
        pickerButton = sender
        var currencyToChange:Currency!
        if sender == butCurrencyFrom {
            currencyToChange = currencyFrom
        } else {
            currencyToChange = currencyTo
        }
        present(PopupCurrency(delegate: self, currentCurrency:currencyToChange), animated: true, completion: nil)
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 0.8 })
    }
    
    
    
    func onCurrencySelected(_ newCurrency: Currency) {
        if pickerButton == butCurrencyFrom {
            currencyFrom = newCurrency
        } else {
            currencyTo = newCurrency
        }
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 1 })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

