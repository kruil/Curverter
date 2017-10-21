//
//  PopupCurrency.swift
//  Curverter
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import UIKit



protocol CurrencyPickerDelegate {
    func onCurrencySelected(_ newCurrency:Currency)
}

//MARK: -

class PopupCurrency: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var pickerView: UIPickerView!
    var delegate:CurrencyPickerDelegate?
    var selectedCurrency:Currency?
    
    //MARK: -
    
    init(delegate:CurrencyPickerDelegate, currentCurrency:Currency) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.modalPresentationStyle = .overFullScreen
        selectedCurrency = currentCurrency
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        if let s = selectedCurrency {
            setInitialSelectionTo(s)
        }
    }
    
    private func setInitialSelectionTo(_ currency:Currency) {
        if let positionToSelect = CurrencyRates.getCurrencyPosition(currency: currency) {
            pickerView.selectRow(positionToSelect, inComponent: 0, animated: false)
        }
    }
    
    @IBAction func onOkTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let delegate = delegate, let selectedCurrency = CurrencyRates.getCurrencyByIndex(pickerView.selectedRow(inComponent: 0)) {
            delegate.onCurrencySelected(selectedCurrency)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: -
extension PopupCurrency: UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyRates.currencyCount()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: -
extension PopupCurrency: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if let currency = CurrencyRates.getCurrencyByIndex(row) {
            let strTitle = currency.code + ", " + currency.name
            let attString = NSAttributedString(string: strTitle, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
            return attString
        }
        return nil
    }
}
