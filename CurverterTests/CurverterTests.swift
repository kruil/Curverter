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
        XCTAssertNotNil(self.vc.butCurrencyFrom, "butCurrencyFrom is nil")
        XCTAssertNotNil(self.vc.butCurrencyTo, "butCurrencyTo is nil")
        XCTAssertNotNil(self.vc.textFieldTo, "textFieldTo is nil")
        XCTAssertNotNil(self.vc.textFieldFrom, "textFieldFrom is nil")
    }
    
    
    func testInitialStateOfCurrencyRates() {
        let _ = CurrencyRates()
        XCTAssert(CurrencyRates.currencies.count > 0, "CurrencyRates dosn't have any currencies.")
    }
    
    
    func testEqualsCurrencyRate(){
        let cur1 = CurrencyRates.getCurrencyByIndex(0)!
        let r = CurrencyRates.convert(amount: 293, from: cur1.code, to: cur1.code)
        XCTAssert(r == 293, "Rate for same currencies not equal 1.")
    }
    
    
    func testGetNonexistingCurrency() {
        XCTAssert(CurrencyRates.getCurrency(code: "---") == nil, "CurrencyRates return currency for nonexistent currency code.")
    }
    

    func testGetRateOfNonexistingCurrency() {
        XCTAssert(CurrencyRates.getRate("---") == nil, "CurrencyRates return rate for nonexistent currency code.")
    }
    
    
    func testCheckInput() {
        XCTAssert(Helper.checkInput(input: "") == "", "Helper.checkInput wrong")
        XCTAssert(Helper.checkInput(input: ".") == "0.", "Helper.checkInput wrong")
        XCTAssert(Helper.checkInput(input: "LETTERS") == "", "Helper.checkInput wrong")
        XCTAssert(Helper.checkInput(input: "LETTERS AND 123.0") == "123.0", "Helper.checkInput wrong")
        XCTAssert(Helper.checkInput(input: "1000000.324") == "1 000 000.32", "Helper.checkInput wrong")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
