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
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    
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
    // Error enumeration
    enum AppError: Error {
        case divideByZero
        case cannotAddOpe
        case ExpressionIsNotCorrect
        case calculateIsEmpty
    }
    // Property Can addOperation
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    // MARK: - Methods
    
    // Add operation if we can
    func addOperator(_ op: String) throws {
        guard canAddOperator else {
            throw AppError.cannotAddOpe
        }
        operators.append(op)
        stringNumbers.append("")
    }
    // Add Number
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    // Perform calcul with priority of operation
    func calculateTotal() throws -> Double {
        guard isExpressionCorrect else {
            if stringNumbers.count == 1 {
                throw AppError.calculateIsEmpty
            } else {
                throw AppError.ExpressionIsNotCorrect
            }
        }
        while stringNumbers.count > 1 {
            if let indexOfDivOrMul = operators.firstIndex(where: { $0 == "*" || $0 == "/"}) {
                let preOp = stringNumbers[indexOfDivOrMul - 1]
                let nextOp = stringNumbers[indexOfDivOrMul]
                let op = operators[indexOfDivOrMul]
                var total: Double
                if Int(nextOp) == 0 {
                    throw AppError.divideByZero
                }
                if op == "*" {
                    total = Double(preOp)! * Double(nextOp)!
                } else {
                    total = Double(preOp)! / Double(nextOp)!
                }
                stringNumbers[indexOfDivOrMul - 1] = "\(total)"
                stringNumbers.remove(at: indexOfDivOrMul)
                operators.remove(at: indexOfDivOrMul)
            } else if let index = operators.lastIndex(where: { $0 == "+" || $0 == "-"}) {
                let preOp = stringNumbers[index - 1]
                let nextOp = stringNumbers[index]
                let op = operators[index]
                var total: Double
                if op == "+" {
                    total = Double(preOp)! + Double(nextOp)!
                } else {
                    total = Double(preOp)! - Double(nextOp)!
                }
                stringNumbers[index - 1] = "\(total)"
                stringNumbers.remove(at: index)
                operators.remove(at: index)
        }
    }
        return Double(stringNumbers[0])!
    }
    //Clear the calculate
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    // display on the calculator
    var operationDisplay: String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        return text
    }
}
