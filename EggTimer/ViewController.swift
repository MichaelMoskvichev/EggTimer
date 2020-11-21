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
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    
    var timer: Timer?
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    @IBAction func EggButton(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        timer?.invalidate()
        totalTime = eggTimes[hardness]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        headLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
    }
    
    @objc func onTimerFires() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            let percetageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = Float(percetageProgress)
            
        } else {
            timer?.invalidate()
            headLabel.text = "Done"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName : String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }

}

