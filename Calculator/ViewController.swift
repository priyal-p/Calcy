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
    private var prevNum: Double = .zero
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
            displayLabel.text = newValue.displayValue
        }
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        let currentNumber = displayValue
        //What should happen when a non-number button is pressed
        if let title = sender.currentTitle {
            if title.isOperator {
                prevNum = currentNumber
                displayLabel.text = ""
                opSymbol = title
            } else if title.isEqualsTo {
                if let value = calculate(currentNumber, prevNum) {
                    displayValue = value
                }
            } else if title.isClear {
                prevNum = .zero
                opSymbol = ""
                displayLabel.text = "0"
                isFinishedTypingNumber = true
            } else if title.isInverted {
                displayValue = displayValue * -1
            } else if title.isPercentage {
                displayValue = displayValue / 100
            }
        }
    }

    private func calculate(_ num1: Double, _ num2: Double) -> Double? {
        var value: Double?
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
            return value
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

extension Double {
    var displayValue: String {
        let isInt = floor(self) == self
        return isInt ? String(Int(self)) : String(self)
    }
}
