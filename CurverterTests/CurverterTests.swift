//
//  CurverterTests.swift
//  CurverterTests
//
//  Created by Илья Крупко on 19.10.17.
//  Copyright © 2017 Илья Крупко. All rights reserved.
//

import XCTest
@testable import Curverter

class CurverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_InitialStateOfCurrencyRates() {
        let _ = CurrencyRates()
        XCTAssert(CurrencyRates.currencies.count > 0, "CurrencyRates dosn't have any currencies.")
    }
    
    
    func test_EqualsCurrencyRate(){
        let cur1 = CurrencyRates.getCurrencyByIndex(0)!
        let r = CurrencyRates.convert(amount: 293, from: cur1.code, to: cur1.code)
        XCTAssert(r == 293, "Rate for same currencies not equal 1.")
    }
    
    
    func test_getNoExistingCurrency() {
        XCTAssert(CurrencyRates.getCurrency(code: "---") == nil, "CurrencyRates return currency for nonexistent currency code.")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
