//
//  ViewController.swift
//  calculator
//
//  Created by SUNG on 1/7/24.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultListView: UITextView!
    
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case divide = "/"
        case none
    }
    
    enum ErrorText: String {
        case leftIsNotNumber = "왼쪽 입력값이 숫자가 아닙니다."
        case rightIsNotNumber = "오른쪽 입력값이 숫자가 아닙니다."
        case cannotDivideByZero = "0으로 나눌 수 없습니다"
        case unkonwnError = "문제가 발생하였습니다. 다시 시도해주세요."
    }
    
    var op:Op = .none
    
    //MARK: view Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        leftTextField.delegate = self
        rightTextField.delegate = self
        resultListView.delegate = self
        
        textViewSetUp()
        
    }
    
    func textViewSetUp() {
        resultListView.showsVerticalScrollIndicator = true // 최초 1회만 쓰는 값 ex)백그라운드색상같은거
        resultListView.isEditable = false
        resultListView.isScrollEnabled = true
    }
    
    //MARK: functions
    func calculate(op: Op) {
        guard let lhsText = leftTextField.text, let lhsNumber = Double(lhsText) else {
            resultLabel.text = ErrorText.leftIsNotNumber.rawValue
            return
        }
        guard let rhsText = rightTextField.text, let rhsNumber = Double(rhsText) else {
            resultLabel.text = ErrorText.rightIsNotNumber.rawValue
            return
        }
        
        var result: Double = 0
        
        switch op {
        case .plus:
            result = lhsNumber + rhsNumber
        case .minus:
            result = lhsNumber - rhsNumber
        case .multiply:
            result = lhsNumber * rhsNumber
        case .divide:
            guard rhsNumber != 0 else {
                resultLabel.text = ErrorText.cannotDivideByZero.rawValue
                return
            }
            
            result = round(Double(lhsNumber) / Double(rhsNumber) * 100) / 100
        case .none:
            return
        }
        
        resultLabel.text = "= \(result)"
        resultListView.text += "\(lhsNumber) \(op.rawValue) \(rhsNumber) = \(result) \n"
        
    }
    
    func updateOperator(newOperator: Op) {
        op = newOperator
        operatorLabel.text = op.rawValue
    }
    
    func clear() {
        leftTextField.text = ""
        operatorLabel.text = "?"
        rightTextField.text = ""
        resultLabel.text = "= 연산결과"
        resultListView.text = ""
    }
    

    //MARK: Actions
    @IBAction func plusButtonClicked(_ sender: UIButton) {
        updateOperator(newOperator: .plus)
    }
    
    @IBAction func minusButtonClicked(_ sender: UIButton) {
        updateOperator(newOperator: .minus)
    }
    
    @IBAction func multplyButtonClicked(_ sender: UIButton) {
        updateOperator(newOperator: .multiply)
    }
    
    @IBAction func divideButtonClicked(_ sender: UIButton) {
        updateOperator(newOperator: .divide)
    }
    
    @IBAction func calculatorButtonClicked(_ sender: UIButton) {
        calculate(op: op)
    }
    
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        clear()
    }
    
    
}

extension ViewController: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count <= 3
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }

        return true
    }
}


