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
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVAudioPlayer?
    var timer = Timer()
    
    var eggTimes = ["Soft":5, "Medium": 7, "Hard": 12]
    var secondRemaining = 0;
    var hardness:String? = nil
    var totalTime = 0
    
    
    @IBAction func HardnessSelection(_ sender: UIButton) {
        hardness = sender.currentTitle
        timer.invalidate()
        
        switch hardness{
        case "Soft":
            titleLabel.text = "It should cook for approximately \(eggTimes[hardness!]!) minutes."
            secondRemaining = eggTimes[hardness!]! * 60
            totalTime = eggTimes[hardness!]! * 60
            
        case "Medium":
            titleLabel.text = "It should cook for approximately \(eggTimes[hardness!]!) minutes."
            secondRemaining = eggTimes[hardness!]! * 60
            totalTime = eggTimes[hardness!]! * 60
        case "Hard":
            titleLabel.text = "It should cook for approximately \(eggTimes[hardness!]!) minutes."
            secondRemaining = eggTimes[hardness!]! * 60
            totalTime = eggTimes[hardness!]! * 60
        default:
            titleLabel.text = "How do you like your eggs?"
        }
        countDownLabel.font = countDownLabel.font.withSize(110)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer(){
        if secondRemaining > 0{
            let min = String(format: "%02d", secondRemaining / 60)
            let sec = String(format: "%02d", secondRemaining % 60)
            countDownLabel.text = "\(min):\(sec)"
            ProgressBar.progress = Float(Float(totalTime - secondRemaining) / Float(totalTime))
            secondRemaining -= 1
        }else {
            timer.invalidate()
            playSound()
            hardness = nil
            countDownLabel.font = countDownLabel.font.withSize(22)
            
            countDownLabel.text = "Your egg is ready to eat. Enjoy your egg!"
        }
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
