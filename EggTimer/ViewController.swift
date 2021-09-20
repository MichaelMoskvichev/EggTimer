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
    
    @IBOutlet weak var minTriger: UILabel!
    @IBOutlet weak var secTriger: UILabel!
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    
    var timer: Timer?
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    var minute = 0
    var seconds = 0
    var timeLeft = 60
    
    @IBAction func EggButton(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        timer?.invalidate()
        totalTime = eggTimes[hardness]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        headLabel.text = hardness
        timeLeft = 60
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        minute = (eggTimes[hardness]! / 60) - 1
        minTriger.text = String(minute)
    }
    
    func playSound(soundName : String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        secTriger.text = "\(timeLeft)"
        
        if minTriger.text == "0"{
            secTriger.text = "0"
            timer?.invalidate()
            headLabel.text = "Done"
            playSound(soundName: "alarm_sound")
            
        } else if timeLeft <= 0 {
            minute -= 1
            minTriger.text = String(minute)
            timeLeft = 60
        
        } else if secondsPassed < totalTime {
            
            secondsPassed += 1
            let percetageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = Float(percetageProgress)
            print(percetageProgress)
            
        } else {
            timer?.invalidate()
            headLabel.text = "Done"
            playSound(soundName: "alarm_sound")
        }
    }
    
    
}

