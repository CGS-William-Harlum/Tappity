//
//  InterfaceController.swift
//  TappityWatch Extension
//
//  Created by William Harlum on 1/6 17.
//  Copyright © 2017 william.harlum. All rights reserved.
//

import WatchKit
import Foundation
import UIKit


class InterfaceController: WKInterfaceController {
    @IBOutlet var points: WKInterfaceLabel!
    @IBOutlet var timer: WKInterfaceLabel!
    
    

    var score = 0
    var seconds = 30
    var timerRunning = false
    
    @IBAction func startGame() {
        if timerRunning == false {
            score += 1
            points.setText("\(score)")
            timerRunning = true
            let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                self.seconds -= 1
                self.timer.setText("\(self.seconds)");
                if self.seconds == 0 {
                    timer.invalidate()
                    popUp()
                    self.score = 0
                    self.seconds = 30
                    self.timer.setText("\(self.seconds)")
                    self.points.setText("\(self.score)")
                    self.timerRunning = false
                }
            }
        } else {
            score += 1
            points.setText("\(score)");
        }
        
        
        func popUp() {
            let action = WKAlertAction(title: "Dismiss", style: WKAlertActionStyle.default) {
            () -> Void in }
            _ = self.presentAlert(withTitle: "Game over", message: "Your score is \(score)", preferredStyle: WKAlertControllerStyle.actionSheet, actions: [action])
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
