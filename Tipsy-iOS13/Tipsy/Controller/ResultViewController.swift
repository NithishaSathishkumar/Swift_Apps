//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Nithisha Sathishkumar on 6/27/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    // Connection to the UI elements
    @IBOutlet weak var splitBill: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    // Global variables to store data passed from the previous view controller
    var numOfPeople: Int = 0
    var tip: Double = 0.0
    var totalBill: String = "0.0"
    
    // Action triggered when the recalculate button is pressed
    @IBAction func recalculatePressed(_ sender: UIButton) {
        
        // Dismiss the current view controller and go back to the previous one
        self.dismiss(animated: true, completion: nil)
    }
    
    //This Main overrides the main page
    override func viewDidLoad() {
        super.viewDidLoad()

        //present the totalBill value per person
        splitBill.text = totalBill
        
        // Set the summary text to display the number of people and tip percentage
        summary.text = "Split between \(numOfPeople) people, with \(Int(tip * 100))% tip."
    }

}
