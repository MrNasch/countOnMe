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
    // Add operator
    @IBAction func tappedOpButton(_ sender: UIButton) {
        addOpe(sender.titleLabel?.text ?? "")
    }
    // Add numer and update the display
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let textButton = sender.titleLabel?.text ?? ""
        guard let value = Int(textButton) else { return }
        calculator.addNewNumber(value)
        updateDisplay()
    }
    // alerts
    func alerts(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }
    // Verify if we can add operator
    func addOpe(_ op: String) {
        do {
            try calculator.addOperator(op)
            updateDisplay()
        } catch Calculator.AppError.cannotAddOpe {
            alerts(title: "Expression incorrect", message: "Must add a numer after an operator")
        } catch {
            //Necessary but not used
        }
    }
    // Multiply
    @IBAction func multiply() {
        addOpe("*")
    }
    //Divide
    @IBAction func divide() {
        addOpe("/")
    }
    // Addition
    @IBAction func plus() {
        addOpe("+")
    }
    // Soustraction
    @IBAction func minus() {
        addOpe("-")
    }
    // Try to calculate and throws Error if there is
    @IBAction func equal() {
        do {
            let total = try calculator.calculateTotal()
            textView.text = "\(total)"
            calculator.clear()
        } catch Calculator.AppError.divideByZero {
            alerts(title: "Division by zero", message: "You cannot divide by zero!")
            calculator.clear()
            updateDisplay()
        } catch Calculator.AppError.calculateIsEmpty {
            alerts(title: "Calculate is Empty", message: "Must add operation")
        } catch {
            //Necessary but not used
        }
        
    }
    // Update text on display
    func updateDisplay() {
        textView.text = calculator.operationDisplay
    }
}
