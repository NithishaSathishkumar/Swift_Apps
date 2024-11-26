//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Connection to the main UI elements
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var splitPeople: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var zeroTip: UIButton!
    @IBOutlet weak var tenTip: UIButton!
    @IBOutlet weak var twentyTip: UIButton!
    
    // Global variables
    var tips = 0.0
    var billTotal = "0.0"
    var numberOfPeople = 2
    
    @IBAction func tipPressed(_ sender: UIButton) {
        billAmount.endEditing(true) // Hide the keyboard
        deSelectButton() // Deselect all tip buttons
        sender.isSelected = true // Select the pressed button
        
        let tip = sender.currentTitle! // Get the title of the pressed button
        
        // Set the tip percentage based on the pressed button
        if(tip == zeroTip.currentTitle){
            tips = 0.0
        }else if(tip == tenTip.currentTitle){
            tips = 0.1
        }else if(tip == twentyTip.currentTitle){
            tips = 0.2
        }
    }
    
    // Deselect all tip buttons
    func deSelectButton(){
        zeroTip.isSelected = false
        tenTip.isSelected = false
        twentyTip.isSelected = false
    }
    
    // +/- the number // Adjust the number of people splitting the bill
    @IBAction func splitAmount(_ sender: UIStepper) {
        //update the number of people to the lable
        splitPeople.text = String(Int(sender.value))
        
        // Update the label to display the current value of the stepper as a string
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //storing the user's bill amount
        let billValue = billAmount.text!
        
        //formula for calculating the bill per person and formating
        billTotal = String(format: "%.2f", Double(billValue)! * (1 + tips) / Double(numberOfPeople))
        
        // Perform the segue to the results screen
        self.performSegue(withIdentifier: "goToResults", sender: self) // Remember:set the identifer in the present modally
    }
    
    //Main
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.stepValue = 1 // +/- the stepper value by 1
    }
    
    // Prepare for the segue to the results screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check if it is the right page and move to the destination and set value to the global var
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.numOfPeople = numberOfPeople
            destinationVC.tip = tips
            destinationVC.totalBill = billTotal
        }
            
    }
    
    
}
    

