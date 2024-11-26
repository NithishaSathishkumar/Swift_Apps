//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    //let softTime = 5
    //let mediumTime = 7
    //let hardTime = 12
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var timerBar: UIProgressView!
    
    let eggTime = ["Soft": 3, "Medium":4, "Hard" : 7]
    //let eggTime = ["Soft": 300, "Medium":420, "Hard" : 720]
    //var counter = 60
    var timer = Timer()
    var player: AVAudioPlayer?
    var totalTime = 0
    var secondPassed = 0
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        timer.invalidate() //end the timer
        let typeEgg = sender.currentTitle!
        totalTime = eggTime[typeEgg]!
        
        timerBar.progress = 0.0;
        secondPassed = 0
        titleText.text = typeEgg
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondPassed < totalTime {
            secondPassed += 1
            timerBar.progress = Float(secondPassed) / Float(totalTime)
            print(Float(secondPassed) / Float(totalTime))
            
        }else{
            timer.invalidate()
            titleText.text = "Done!"
            
//            if let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
//                do {
//                    player = try AVAudioPlayer(contentsOf: url)
//                    player?.numberOfLoops = 0
//                    player?.play()
//                    timer.invalidate()
//                } catch {
//                    print("Error playing sound")
//                }
//            }
            
        }
    }
}

    
    


