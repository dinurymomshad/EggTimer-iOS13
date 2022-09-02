//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // A dictionary holding required time to cook a
    // a soft or medium or hard egg
    let eggTimes : [String : Int] = ["Soft": 10, "Medium": 700, "Hard": 1000]
    // Cooking duration
    var eggTimer: Int = 60
    // Timer handles duration
    var timer: Timer = Timer()
    var isTimerRunning: Bool = false
    
    // User can define their preferred egg type. Based
    // their selection, timer will run. For example if
    // user wants their egg medium cooked then timer will
    // run for 700 seconds
    @IBAction func selectedHardness(_ sender: UIButton) {
        let hardness = sender.currentTitle
        eggTimer = eggTimes[hardness!]!
        runTimer();
    }
    
    // This function runs the timer and checks for various
    // scenerios
    func runTimer() {
        if(isTimerRunning) {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(!isTimerRunning){
            isTimerRunning = true
        }
        
        eggTimer -= 1
        print(eggTimer)
        
        if(eggTimer == 0) {
            timer.invalidate()
        }
    }
    
    // User can turn off egg timer at any time if it's running
    @IBAction func onStopButtonPressed(_ sender: Any) {
        if(isTimerRunning) {
            timer.invalidate()
        }
    }
}
