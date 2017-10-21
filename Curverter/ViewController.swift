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
    @IBOutlet weak var textFieldAmount1: UITextField!
    @IBOutlet weak var textFieldAmount2: UITextField!
    
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
        Helper.addDoneToTextFieldKeyboard(textField: textFieldAmount1)
        Helper.addDoneToTextFieldKeyboard(textField: textFieldAmount2)
        textFieldAmount1.text = "1"
        onSumChanged(textFieldAmount1)
    }
    
    @IBAction func onSumChanged(_ sender: UITextField) {
        guard currency1 != nil, currency2 != nil else { return }
        if sender == textFieldAmount1 {
            updateTextField(changedTextField: textFieldAmount1, textFieldToChange: textFieldAmount2)
        }
        else {
            updateTextField(changedTextField: textFieldAmount2, textFieldToChange: textFieldAmount1)
        }
    }
    
    func updateTextField(changedTextField:UITextField, textFieldToChange:UITextField){
        changedTextField.text = Helper.checkForDecimalInput(input: changedTextField.text!)
        let amount = Helper.inputToDouble(input: changedTextField.text!)
        let convertedAmount = CurrencyRates.convert(amount: amount,
                                                    from: getCurrencyFor(view: changedTextField),
                                                    to: getCurrencyFor(view: textFieldToChange))
        textFieldToChange.text = Helper.checkForDecimalInput(input: String(convertedAmount))
    }
    
    func getCurrencyFor(view:UIView) -> Currency{
        if view == textFieldAmount1 || view == butSelectCurrency1 {
            return currency1
        } else {
            return currency2
        }
    }
    
    @IBAction func selectNewCurrency(_ sender: UIButton) {
        currencyPickerButton = sender
        let currencyToChange = getCurrencyFor(view: sender)
        present(PopupCurrency(delegate: self, currentCurrency:currencyToChange), animated: true, completion: nil)
        UIView.animate(withDuration: 0.5, animations: { self.view.alpha = 0.8 }) // shade view controller
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

