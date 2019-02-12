//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calculator = Calculator()
    
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operators: [UIButton]!
    
    // MARK: - Action
    @IBAction func tappedOpButton(_ sender: UIButton) {
        switch sender.tag {
        case 11:
            minus()
        case 12:
            plus()
        case 13:
            divide()
        case 14:
            multiply()
        case 15:
            calculator.calculateTotal()
        default:
            break
        }
    }
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNewNumber(sender.tag)
        updateDisplay()
    }
    func alerts() {
        if calculator.stringNumbers.count <= 0 {
            let alertVC = UIAlertController(title: "Zéro!", message: "Start a new operation", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else if calculator.stringNumbers == ["0"]{
            let alertVC = UIAlertController(title: "Zéro!", message: "You cannot divide by zero", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Enter correct expression", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    func addOperator(_ op: String) {
        if calculator.addOperator(op) {
            updateDisplay()
        } else {
            var isExpressionCorrect: Bool {
                if let stringNumber = calculator.stringNumbers.last {
                    if stringNumber.isEmpty {
                        alerts()
                        return false
                    }
                }
                return true
            }
        }
    }
    
    @IBAction func multiply() {
        addOperator("*")
    }
    
    @IBAction func divide() {
       addOperator("/")
    }

    @IBAction func plus() {
        addOperator("+")
    }

    @IBAction func minus() {
        addOperator("-")
    }

    @IBAction func equal() {
        alerts()
        updateDisplay()
        let total = calculator.calculateTotal()
        textView.text! = "\(Double(total))"
        calculator.clear()
    }
    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in calculator.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += calculator.operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
   
}
