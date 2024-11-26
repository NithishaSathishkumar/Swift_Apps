//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Nithisha Sathishkumar on 6/26/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    
    var bMI: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float){
        let bmi = (weight / pow(height, 2))
        
        if(bmi < 18.5){
            bMI = BMI(value: bmi, advice: "Eat More Pies.", color: UIColor.systemBlue)
        }else if(bmi < 24.9){
            bMI = BMI(value: bmi, advice: "Fir As A Fiddle", color: UIColor.systemGreen)
        }else{
            bMI = BMI(value: bmi, advice: "Eat Less Pies!", color: UIColor.systemRed)
        }
    }
    
    func getBMIValue() -> String{
//        if(BMI != nil){
//            return String(format: "%.1f", BMI!)
//        }else{
//            return "0.0"
//        }
        
        return String(format: "%.1f", bMI?.value ?? 0.0)
    
    }
    
    func getAdvice() -> String{
        return bMI?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor{
        return bMI?.color ?? UIColor.white
        
    }
}
