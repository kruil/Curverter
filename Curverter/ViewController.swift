//
//  ViewController.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var butSelectCurrency1: UIButton!
    @IBOutlet weak var butSelectCurrency2: UIButton!
    @IBOutlet weak var textFieldAmount1: DecimalTextField!
    @IBOutlet weak var textFieldAmount2: DecimalTextField!
    private var currencyPickerButton:UIButton?
    
    private var currency1:Currency! {
        didSet(a) {
            butSelectCurrency1.setTitle(currency1.name, for: .normal)
            onSumChanged(textFieldAmount1)
        }
    }
    
    private var currency2:Currency! {
        didSet(a) {
            butSelectCurrency2.setTitle(currency2.name, for: .normal)
            onSumChanged(textFieldAmount1)
        }
    }
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        currency1 = CurrencyRates.getCurrency(code: "USD")
        currency2 = CurrencyRates.getCurrency(code: "SEK")
        butSelectCurrency1.setTitle(currency1.name, for: .normal)
        butSelectCurrency2.setTitle(currency2.name, for: .normal)
        textFieldAmount1.text = "1"
        onSumChanged(textFieldAmount1)
    }
    
    @IBAction func onSumChanged(_ sender: DecimalTextField) {
        guard currency1 != nil, currency2 != nil else { return }
        let amount = sender.amount
        var textFieldToChange:DecimalTextField!
        if sender == textFieldAmount1 {
            textFieldToChange = textFieldAmount2
        }
        else {
            textFieldToChange = textFieldAmount1
        }
        let convertedAmount = CurrencyRates.convert(amount: amount, from: getCurrencyFor(view: sender), to: getCurrencyFor(view: textFieldToChange))
        textFieldToChange.amount = convertedAmount
    }
    
    func getCurrencyFor(view:UIView) -> Currency {
        if view == textFieldAmount1 || view == butSelectCurrency1 {
            return currency1
        } else {
            return currency2
        }
    }
    
    @IBAction func selectNewCurrency(_ sender: UIButton) {
        currencyPickerButton = sender
        present(PopupCurrency(delegate: self, currentCurrency: getCurrencyFor(view: sender)), animated: true, completion: nil)
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 0.8 }) // shade view controller
    }
}

//MARK: -
extension ViewController: CurrencyPickerDelegate {
    internal func onCurrencySelected(_ newCurrency: Currency) {
        if currencyPickerButton == butSelectCurrency1 {
            currency1 = newCurrency
        } else {
            currency2 = newCurrency
        }
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 1 }) // unshade view controller
    }
}

