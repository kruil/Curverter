//
//  CurverterTests.swift
//  CurverterTests
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import XCTest
import UIKit
@testable import Curverter

class CurverterTests: XCTestCase {
    
    var vc:ViewController!
    
    override func setUp() {
        super.setUp()
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.vc = storyboard.instantiateViewController(withIdentifier: "main") as! ViewController
        self.vc.loadView()
        self.vc.viewDidLoad()
    }
    
    override func tearDown() {
        vc = nil
        super.tearDown()
    }
    
    func testViewController() {
        XCTAssertNotNil(self.vc, "Main view controller is nil")
        XCTAssertNotNil(self.vc.butSelectCurrency1, "butCurrencyFrom is nil")
        XCTAssertNotNil(self.vc.butSelectCurrency2, "butCurrencyTo is nil")
        XCTAssertNotNil(self.vc.textFieldAmount1, "textFieldTo is nil")
        XCTAssertNotNil(self.vc.textFieldAmount2, "textFieldFrom is nil")
    }
    
    func testInitialStateOfCurrencyRates() {
        let _ = CurrencyRates()
        XCTAssert(CurrencyRates.currencyCount() > 0, "CurrencyRates dosn't have any currencies.")
    }
    
    func testEqualsCurrencyRate(){
        let cur1 = CurrencyRates.getCurrencyByIndex(0)!
        let r = CurrencyRates.convert(amount: 293, from: cur1, to: cur1)
        XCTAssert(r == 293, "Rate for same currencies not equal 1.")
    }
    
    func testGetNonexistingCurrency() {
        XCTAssert(CurrencyRates.getCurrency(code: "---") == nil, "CurrencyRates return currency for nonexistent currency code.")
    }
    
    func testCheckInput() {
        let decimalTextField = DecimalTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        decimalTextField.amount = 0.0
        XCTAssert(decimalTextField.text == "0","Helper.checkInput wrong")
        decimalTextField.amount = 45.1
        XCTAssert(decimalTextField.text == "45.10","Helper.checkInput wrong")
        decimalTextField.amount = 12345.0
        XCTAssert(decimalTextField.text == "12 345","Helper.checkInput wrong")
        XCTAssert(decimalTextField.amount == 12345.0 ,"Helper.checkInput wrong")
    }
}
