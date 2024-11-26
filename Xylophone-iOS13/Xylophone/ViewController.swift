//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation //use libray


class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    @IBAction func keyPressed(_ sender: UIButton) {
        //print(sender.titleLabel?.text)
        if(sender.titleLabel?.text == "C"){
            playSound(sound: "C")
            Opacity(sender: sender)
        }else if(sender.titleLabel?.text == "D"){
            playSound(sound: "D")
            Opacity(sender: sender)
        }else if(sender.titleLabel?.text == "E"){
            playSound(sound: "E")
            Opacity(sender: sender)
        }else if(sender.titleLabel?.text == "F"){
            playSound(sound: "F")
            Opacity(sender: sender)
        }else if(sender.titleLabel?.text == "G"){
            playSound(sound: "G")
            Opacity(sender: sender)
        }else if(sender.titleLabel?.text == "A"){
            playSound(sound: "A")
            Opacity(sender: sender)
        }else{
            playSound(sound: "B")
            Opacity(sender: sender)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playSound(sound: String) {
        // Attempt to find the path for the sound file in the main bundle
        guard let path = Bundle.main.path(forResource: sound, ofType: "wav") else {
            // If the path is not found, exit the function
            return
        }
        
        // Create a URL object with the file path
        let url = URL(fileURLWithPath: path)

        do {
            // Attempt to initialize the AVAudioPlayer with the URL of the sound file
            player = try AVAudioPlayer(contentsOf: url)
            
            // Play the sound
            player?.play()
        } catch let error {
            // Print an error message if the AVAudioPlayer initialization or playing fails
            print(error.localizedDescription)
        }
    }

    func Opacity(sender: UIButton){
        //Reduces the sender's (the button that got pressed) opacity to half
        sender.alpha = 0.5
        
        //Code should execute after 0.6 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
             //Bring's sender's opacity back up to fully opaque.
             sender.alpha = 1.0
         }
    }
    
}
