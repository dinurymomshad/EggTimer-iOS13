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
    var player: AVAudioPlayer!
    
    // A dictionary holding required time to cook a soft or medium or hard egg
    let eggTimes : [String : Int] = ["Soft": 300, "Medium": 400, "Hard": 720]
    
    // Timer handles duration
    var timer: Timer = Timer()
    var isTimerRunning: Bool = false
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // User can define their preferred egg type. Based
    // their selection, timer will run. For example if
    // user wants their egg medium cooked then timer will
    // run for 700 seconds
    @IBAction func selectedHardness(_ sender: UIButton) {
        progressBar.progress = 0.0
        secondsPassed = 0
        
        let hardness = sender.currentTitle
        totalTime = eggTimes[hardness!]!
        
        headerLabel.text = hardness
        runTimer();
    }
    
    // This function runs the timer and checks for various scenerios
    func runTimer() {
        if isTimerRunning {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Updates the timer and handles updating the UI
    @objc func updateTimer() {
        if !isTimerRunning {
            isTimerRunning = true
        }
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress: Float = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        }
        else {
            timer.invalidate()
            playAlarm()
            headerLabel.text = "DONE"
        }
    }
    
    // User can turn off egg timer at any time if it's running
    @IBAction func onStopButtonPressed(_ sender: Any) {
        if isTimerRunning {
            timer.invalidate()
        }
    }
    
    // Plays alarm when timer is up
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
