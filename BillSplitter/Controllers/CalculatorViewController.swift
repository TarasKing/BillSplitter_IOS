//
//  ViewController.swift
//  BillSplitter
//
//  Created by Taras on 16/10/2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    //Variables
    var totalSumPerPerson: Double = 0.0
    var finalText: String = ""
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        billTextField.endEditing(true)
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func tipSlider(_ sender: UISlider) {
        
        billTextField.endEditing(true)

        tipTextField.text = String(Int(sender.value))
    }
    
    @IBAction func CalculatePressed(_ sender: UIButton) {
        if  tipTextField.text == nil {
            tipTextField.text = String("0");
        }
        if splitNumberLabel.text == nil {
            splitNumberLabel.text = String("0")
        }
        var inputSum = Double(billTextField.text!) ?? 0.0
        
        let tipsAmount = Double((Double(tipTextField.text!) ?? 0.0)/100)
        let amountOfPersons = Int(splitNumberLabel.text!) ?? 0
        let totalSum = inputSum * tipsAmount + inputSum
        
        totalSumPerPerson = round(totalSum / Double(amountOfPersons) * 100) / 100.0
        finalText = "Sum \(totalSum) splitted betwen \(amountOfPersons) people, with \(Int(tipsAmount * 100)) %. Per person \(totalSumPerPerson)"
        print(finalText)
  
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultTotalSumPerPerson = totalSumPerPerson
            destinationVC.resultText = finalText
        }
    }


}
 
