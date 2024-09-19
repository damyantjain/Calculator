//
//  ViewController.swift
//  Calculator
//
//  Created by Damyant Jain on 9/16/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstNumber: UITextField!
    @IBOutlet var secondNumber: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var addNumber: UIButton!
    @IBOutlet var divideNumber: UIButton!
    @IBOutlet var multiplyNumber: UIButton!
    @IBOutlet var subtractNumber: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addNumber.addTarget(self, action: #selector(onButtonClickAdd), for: .touchUpInside)
        subtractNumber.addTarget(self, action: #selector(onButtonClickSubtract), for: .touchUpInside)
        multiplyNumber.addTarget(self, action: #selector(onButtonClickMultiply), for: .touchUpInside)
        divideNumber.addTarget(self, action: #selector(onButtonClickDivide), for: .touchUpInside)
        
        firstNumber.addTarget(self, action: #selector(onTextFieldUpdate), for: .editingChanged)
        secondNumber.addTarget(self, action: #selector(onTextFieldUpdate), for: .editingChanged)
        onTextFieldUpdate();
    }
    
    @objc func onTextFieldUpdate(){
        if let text1 = firstNumber.text, !text1.isEmpty,
           let text2 = secondNumber.text, !text2.isEmpty {
            enableButtons()
        } else {
            disableButtons()
        }
    }
    
    func disableButtons() {
        addNumber.isEnabled = false
        subtractNumber.isEnabled = false
        multiplyNumber.isEnabled = false
        divideNumber.isEnabled = false
        errorLabel.isHidden = false
    }
    
    func enableButtons() {
        addNumber.isEnabled = true
        subtractNumber.isEnabled = true
        multiplyNumber.isEnabled = true
        divideNumber.isEnabled = true
        errorLabel.isHidden = true
    }
    
    @objc func onButtonClickAdd(){
        let numbers = validateNumbers();
        if(!numbers.0){
            return
        }
        resultLabel.text = String(format: "%.2f", numbers.1 + numbers.2)
    }
    
    @objc func onButtonClickDivide(){
        let numbers = validateNumbers();
        if(!numbers.0){
            return
        }
        if(numbers.2 == 0){
            showErrorAlert("Error", "Division by zero is not possible")
            resultLabel.text = "Result"
        } else {
            resultLabel.text = String(format: "%.2f", numbers.1 / numbers.2)
        }
    }
    
    @objc func onButtonClickSubtract(){
        let numbers = validateNumbers();
        if(!numbers.0){
            return
        }
        resultLabel.text = String(format: "%.2f", numbers.1 - numbers.2)
    }
    
    @objc func onButtonClickMultiply(){
        let numbers = validateNumbers();
        if(!numbers.0){
            return
        }
        resultLabel.text = String(format: "%.2f", numbers.1 * numbers.2)
    }
    
    func showErrorAlert(_ title:String, _ message:String){
        let alert = UIAlertController(
            title: "\(title)", message: "\(message)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func validateNumbers() -> (Bool, Double, Double){
        var number1:Double = 0;
        var number2:Double = 0;
        var isValid:Bool = false;
        
        if let str1 = firstNumber.text, let num1 = Double(str1){
            number1 = Double(num1)
            isValid = true
        } else {
            print("First number is empty")
            isValid = false
        }
        if let str2 = secondNumber.text, let num2 = Double(str2){
            number2 = Double(num2)
            isValid = true
        } else {
            print("Second number is empty")
            isValid = false
        }
        return (isValid, number1, number2);
    }
    
}

