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



class PopupCurrency: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var delegate:CurrencyPickerDelegate?
    var selectedCurrency:Currency?
    
    
    init(delegate:CurrencyPickerDelegate, currentCurrency:Currency) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.modalPresentationStyle = .overFullScreen
        selectedCurrency = currentCurrency
    }
    
    
    private func setInitialSelectionTo(_ currency:Currency) {
        if let positionToSelect = CurrencyRates.getCurrencyPosition(currency: currency) {
            pickerView.selectRow(positionToSelect, inComponent: 0, animated: false)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let s = selectedCurrency {
            setInitialSelectionTo(s)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyRates.currencies.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let strTitle = CurrencyRates.currencies[row].code + ", " + CurrencyRates.currencies[row].name
        let attString = NSAttributedString(string: strTitle, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
        return attString
    }
    
    
    @IBAction func onOkTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let d = delegate {
            let selectedCurrency = CurrencyRates.currencies[pickerView.selectedRow(inComponent: 0)]
            d.onCurrencySelected(selectedCurrency)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
