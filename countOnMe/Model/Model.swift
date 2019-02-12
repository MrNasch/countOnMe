//
//  Model.swift
//  CountOnMe
//
//  Created by Nasch on 05/02/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Properties
    var stringNumbers: [String] = []
    var operators = ["+"]
    var index = 0
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    return false
                }
                return false
            }
        }
        return true
    }
    // 4 x 5 + 3 x 3 ==> Origin
    //  20   + 3 x 3 ==> Step 1
    //  20   +   9   ==> Step2
    //      29       ==> final
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    // MARK: - Methods
    
    
    func addOperator(_ op: String) -> Bool {
        if canAddOperator {
            operators.append(op)
            stringNumbers.append("")
        } else {
            return false
        }
        return true
    }
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    // PEMDAS
    func calculateTotal() -> Double {
        var Operand: Double = 0
        var Operation = ""
        var total: Double = 0
        
        func performOperation(operand: Double, operation: String, total: Double) -> Double {
            switch operation {
            case "+":
                return operand + total
            case "-":
                return operand - total
            default:
                return total
            }
        }
        //while stringNumbers.count < 1 {}
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                switch operators[i] {
                case "+":
                    total = performOperation(operand: Operand, operation: Operation, total: total)
                    Operand = total
                    Operation = "+"
                    total = number
                case "-":
                    total = performOperation(operand: Operand, operation: Operation, total: total)
                    Operand = total
                    Operation = "-"
                    total = number
                case "/":
                    total /= number
                case "*":
                    total *= number
                default: ()
                }
            }
        }
        // return total
        total = performOperation(operand: Operand, operation: Operation, total: total)
        return total
    }
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
