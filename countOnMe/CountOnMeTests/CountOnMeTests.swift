//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Nasch on 22/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var calculator = Calculator()
    
    func testGivenFirstNumberIsSeven_WhenAdditionningWithNumberEight_ThenTotalIsFiveTeen() {
        calculator.addNewNumber(7)
        
        try! calculator.addOperator("+")
        calculator.addNewNumber(8)
        
        XCTAssertEqual(try calculator.calculateTotal(), 15)
    }
    func testGivenFirstNumberIsFive_WhenSoustractionWithNumberTwo_ThenTotalIsThree() {
        calculator.addNewNumber(5)
        
        try! calculator.addOperator("-")
        calculator.addNewNumber(2)
        
        XCTAssertEqual(try calculator.calculateTotal(), 3)
    }
    func testGivenFirstNumberIsFour_WhenMultiplyWithNumberTwo_ThenTotalIsEight() {
        calculator.addNewNumber(4)
        
        try! calculator.addOperator("*")
        calculator.addNewNumber(2)
        
        XCTAssertEqual(try calculator.calculateTotal(), 8)
    }
    func testGivenFirstNumberIsFive_WhenDivideWithNumberTwo_ThenTotalIsTwoPointFive() {
        calculator.addNewNumber(5)
        
        try! calculator.addOperator("/")
        calculator.addNewNumber(2)
        
        XCTAssertEqual(try calculator.calculateTotal(), 2.5)
    }
//    func testGivenAppLaunchedWhenPressNumberButtonThenUpdateDisplay() {
//
//        calculator.stringNumbers = ["1"]
//        try! calculator.addOperator("/")
//        calculator.stringNumbers = ["0"]
//
//
//        XCTAssertThrowsError(try calculator.calculateTotal())
//
//    }
}
