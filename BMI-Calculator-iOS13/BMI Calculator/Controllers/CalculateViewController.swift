//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var height: UISlider!
    @IBOutlet weak var weight: UISlider!
    
    var calculateBrain = CalculatorBrain()
    
    var BMI = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func heightSlider(_ sender: UISlider) {
        let heightChange = String(format: "%.2f", sender.value)
        heightLable.text = "\(heightChange)m"
    }
    
    
    @IBAction func weightSlider(_ sender: UISlider) {
        let weightChange = Int(sender.value)
        weightLable.text = "\(String(weightChange))Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let heightValue = height.value
        let weightValue = weight.value
        
        calculateBrain.calculateBMI(height: heightValue, weight: weightValue)
        
//        let secondVC = ResultViewController()
//        secondVC.bmiValue = String(format: "%.1f", BMI)
//        self.present(secondVC, animated: true, completion: nil) //completion: once the animated is done do nothing
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToResults"){
            let destinatioVC = segue.destination as! ResultViewController
            destinatioVC.bmiValue = calculateBrain.getBMIValue()
            destinatioVC.advice = calculateBrain.getAdvice()
            destinatioVC.color = calculateBrain.getColor()
        }
        
    }
}

