//
//  CalcyEngine.swift
//  Calculator
//
//  Created by Priyal PORWAL on 09/04/24.
//  Copyright © 2024 London App Brewery. All rights reserved.
//

import Foundation

class CalcyEngine {
    private var prevNum: Double?
    private var currentNumber: Double = .zero

    private var opSymbol: String = ""
    var isLastSelectedOperator: Bool = false

    func calculate(with title: String) -> Double? {
        //What should happen when a non-number button is pressed
        if title.isOperator {
            opSymbol = title
            self.isLastSelectedOperator = true
            if let prevNum = prevNum {
                self.prevNum = calculate(prevNum, currentNumber)
            } else {
                prevNum = currentNumber
            }
            return self.prevNum
        } else if title.isEqualsTo, let prevNum {
            if isLastSelectedOperator {
                return self.prevNum
            } else {
                let value = calculate(prevNum, currentNumber)
                self.prevNum = nil
                self.currentNumber = .zero
                self.opSymbol = ""
                return value
            }
        } else if title.isClear {
            prevNum = nil
            opSymbol = ""
            return 0
        } else if title.isInverted {
            return currentNumber * -1
        } else if title.isPercentage {
            return currentNumber / 100
        } else {
            return nil
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
            fatalError("Invalid Operator")
        }
        return value
    }

    func updateCurrentValue(_ value: Double) {
        self.currentNumber = value
    }
}
