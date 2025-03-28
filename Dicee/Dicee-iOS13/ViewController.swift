//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //interface builder outlet looks
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    //var leftDiceNumber = 0
    //var rightDiceNumber = 5
    
//    override func viewDidLoad() { //things to view when the app opens
//        
//        super.viewDidLoad()
//        
//        //who.what = value
//        //diceImageView1.image = UIImage(named: "DiceSix")
//        //diceImageView1.alpha = 0.5 //opacity
//        //diceImageView2.image = UIImage(named: "DiceTwo")

//    }
    //Action
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        //print("Button got Pressed!")
        //let is a constant
        let diceArray = [UIImage(named: "DiceOne"), UIImage(named: "DiceTwo"), UIImage(named: "DiceThree"), UIImage(named:"DiceFour"), UIImage(named:"DiceFive"), UIImage(named:"DiceSix")]
        
        // Int.random(in: 0...6) == diceArray.randomElement()!! : random number generator
        diceImageView1.image = diceArray.randomElement()!!
        diceImageView2.image = diceArray[Int.random(in: 0...5)]
        
        
        
    }
    

}

