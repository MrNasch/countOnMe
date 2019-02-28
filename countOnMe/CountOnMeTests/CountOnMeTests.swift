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
    enum AppError: Error {
        case divideByZero
        case cannotAddOpe
        case ExpressionIsNotCorrect
        case calculateIsEmpty
    }
    
    func testGivenIfMultiPlyAndOrDivision_WhenCalculateTotalWithAdditionAndOrSoustraction_ThenDoMultiplyAndDivisionBeforeAdditionSoustraction() {
        calculator.addNewNumber(6)
        try! calculator.addOperator("+")
        calculator.addNewNumber(5)
        try! calculator.addOperator("*")
        calculator.addNewNumber(4)
        try! calculator.addOperator("/")
        calculator.addNewNumber(2)
        try! calculator.addOperator("-")
        calculator.addNewNumber(2)
        
        
        let text = calculator.operationDisplay
        
        XCTAssertEqual(text, "6+5*4/2-2")
        XCTAssertEqual(try calculator.calculateTotal(), 14)
    }
    func testGivenOperationCalculated_WhenWantToMakeNewOperation_ThenClearTheDisplay() {

        calculator.clear()
        XCTAssert(calculator.stringNumbers == [""])
        XCTAssert(calculator.operators == ["+"])
    }
    func testGivenWantToPerformOperation_WhenDivideByZero_ThenThrowErrorDivideByZero() {
        calculator.stringNumbers = ["0"]
        try! calculator.addOperator("/")

        XCTAssertThrowsError(try calculator.calculateTotal())
    }
    func testGivenApplicationlaunched_WhenTappingEqualButton_ThenThrowErrorCalculateIsEmpty() {
        XCTAssertThrowsError(try calculator.calculateTotal())
    }
    func testGivenStringNumersPresent_WhenTappingOpButton_ThenCanAddOperator() {
        calculator.stringNumbers[0] = ""
        XCTAssertFalse(calculator.canAddOperator)
    }
    func testGivenOperationAlreadyTapped_WhenTappedOperatorButton_ThenThrowError() {
        do {
            calculator.operators[0] = "+"
            try calculator.addOperator("/")
        } catch {
            XCTAssertThrowsError(try calculator.calculateTotal())
        }
    }
}
