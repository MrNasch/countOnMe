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
        var total: Double = 0
        while stringNumbers.count < 1 {
            print(stringNumbers)
            if let indexOfDivOrMul = operators.firstIndex(where: { $0 == "*" || $0 == "/"}) {
                let preOp = stringNumbers[indexOfDivOrMul - 1]
                let nextOp = stringNumbers[indexOfDivOrMul]
                let op = operators[indexOfDivOrMul]
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
        return total
    }
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
