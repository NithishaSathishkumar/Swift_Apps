//
//  BMI.swift
//  BMI Calculator
//
//  Created by Nithisha Sathishkumar on 6/26/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct BMI {
    let value : Float
    let advice : String
    let color : UIColor
    
    init(value: Float, advice: String, color: UIColor) {
        self.value = value
        self.advice = advice
        self.color = color
    }
}
