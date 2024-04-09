//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber = true
    private var currentNumber: String = ""
    private var prevNum: String = ""
    private var opSymbol: String = ""

    private var displayValue: Double {
        get {
            guard let currentDisplayedText = displayLabel.text, 
                    let doubleValue = Double(currentDisplayedText) else {
                fatalError("Cannot convert displayLabel text to Double")
            }
            return doubleValue
        }
        set {

        }
    }
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        currentNumber = displayLabel.text ?? ""
        //What should happen when a non-number button is pressed
        if let title = sender.currentTitle {
            if title.isOperator {
                prevNum = currentNumber
                currentNumber = ""
                displayLabel.text = ""
                opSymbol = title
            } else if title.isEqualsTo {
                if let num2 = Int(currentNumber),
                   let num1 = Int(prevNum),
                   let value = calculate(num1, num2) {
                    currentNumber = "\(value)"
                }
            } else if title.isClear {
                currentNumber = ""
                prevNum = ""
                opSymbol = ""
                displayLabel.text = "0"
                isFinishedTypingNumber = true
            } else if title.isInverted {
                if let num = Int(currentNumber) {
                    currentNumber = String(num * -1)
                    displayLabel.text = currentNumber
                }
            } else if title.isPercentage {
                if let num = Int(currentNumber) {
                    currentNumber = String(Double(num) / 100)
                    displayLabel.text = currentNumber
                }
            }
        }
    }

    private func calculate<T: BinaryInteger>(_ num1: T, _ num2: T) -> T? {
        var value: T?
        switch opSymbol {
        case "+" :
            value = num1 + num2
        case "-":
            value = num1 - num2
        case "x":
            value = num1 * num2
        case "÷":
            value = num1 / num2
        default:
            displayLabel.text = ""
        }
        if let value {
            displayLabel.text = "\(value)"
        }
        return value
    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let title = sender.currentTitle {
            if isFinishedTypingNumber{
                displayLabel.text = title
                isFinishedTypingNumber = false
            } else {
                if title == "." {
                    let isInt = floor(displayValue) == displayValue
                    if !isInt { return }
                }
                displayLabel.text = (displayLabel.text ?? "") + title
            }
        }
    }

}

extension String {
    var isOperator: Bool {
        return self == "+" || self == "-" || self == "x" || self == "/"
    }

    var isEqualsTo: Bool {
        return self == "="
    }

    var isClear: Bool {
        return self == "AC"
    }

    var isInverted: Bool {
        return self == "+/-"
    }

    var isPercentage: Bool {
        return self == "%"
    }
}
