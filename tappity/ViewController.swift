//
//  ViewController.swift
//  tappity
//
//  Created by William Harlum on 29/5 17.
//  Copyright © 2017 william.harlum. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    

    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timeCon: NSLayoutConstraint!
    @IBOutlet weak var timercon: NSLayoutConstraint!
    @IBOutlet weak var scorecon: NSLayoutConstraint!
    @IBOutlet weak var pointscon: NSLayoutConstraint!
    
    
    
    
    
    
    var score = 0
    var seconds = 30
    var timerRunning = false
    let colors = [UIColor.blue, UIColor.red, UIColor.green, UIColor.purple, UIColor.black, UIColor.orange, UIColor.yellow, UIColor.magenta, UIColor.gray, UIColor.brown]
    var highscores = [0,0,0,0,0,0,0,0,0,0,0]
    var highscoreNames = ["","","","","","","","","",""]
    
    
    
    @IBAction func startGame() {
        
        let theHighScoresViewController = tabBarController!.viewControllers![1] as! HighscoreViewController
        if timerRunning == false {
            view.backgroundColor = colors[Int(arc4random_uniform(9))]
            score += 1
            points.text = ("\(score)");
            self.timerRunning = true
            self.moveButton(button: button)
            let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                self.seconds -= 1
                self.timer.text = ("\(self.seconds)");
                if self.seconds == 0 {
                    var repeats = 0
                    timer.invalidate()
                    
                    func highscoresChang(){
                        if repeats < 10{
                        if self.score < self.highscores[9] {
                            self.alert()
                        }
                        print(repeats)
                        if self.score > self.highscores[repeats] {
                            
                                self.highscores.insert(self.score, at: repeats)
                                self.highscores.remove(at: self.highscores.count - 1)
                                self.HighscoreAlert(repeats: repeats)
                                self.highscoreNames.remove(at: self.highscoreNames.count - 1)
                                UserDefaults.standard.setValue(self.highscores, forKey: "highscores")
                            
                            
                        }else{
                            repeats += 1
                            highscoresChang()
                        }
                    }
                    }
                    highscoresChang()
                    self.reset()
                }
                
            }
        } else {
            score += 1
            points.text = ("\(score)");
            view.backgroundColor = colors[Int(arc4random_uniform(9))]
            moveButton(button: button)
        }
}
    func reset() {
        score = 0
        seconds = 30
        timer.text = ("\(seconds)");
        points.text = ("\(score)");
        timerRunning = false
        view.backgroundColor = UIColor.blue
        button.center.x = button.superview!.bounds.width / 2
        button.center.y = button.superview!.bounds.height / 2
        
    }

    func alert(){
        let alert = UIAlertController(title: "Gameover", message: "Your score is \(score)", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
 
        
    }
    
    @IBAction func moveButton(button: UIButton) {

        let buttonWidth = button.frame.width
        let buttonHeight = button.frame.height

        let viewWidth = button.superview!.bounds.width
        let viewHeight = button.superview!.bounds.height
        
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight
        
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        button.center.x = xoffset + buttonWidth / 2
        button.center.y = yoffset + buttonHeight / 2
    }
    
  
    func HighscoreAlert(repeats: Int){
        let theHighScoresViewController = tabBarController!.viewControllers![1] as! HighscoreViewController
        let alertController = UIAlertController(title: "Highscore", message: "Your score is \(score)", preferredStyle: UIAlertControllerStyle.alert)
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            self.highscoreNames.insert(firstTextField.text!, at: repeats)
            for index in 0...8 {
                theHighScoresViewController.kek(score: self.highscores[index], number:index, Name: self.highscoreNames[index])
                UserDefaults.standard.setValue(self.highscoreNames, forKey: "names")
                }
            })
            self.reset()
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
                textField.clearButtonMode = .whileEditing
        }
        
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
}
    func moveReset(){
        button.center.x = button.superview!.bounds.width / 2
        button.center.y = button.superview!.bounds.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let theHighScoresViewController = tabBarController!.viewControllers![1] as! HighscoreViewController
        
        tabBarController?.selectedIndex = 1
        tabBarController?.selectedIndex = 0
        moveReset()
        
        var defaults = UserDefaults.standard
        self.highscores = defaults.object(forKey: "highscores") as? [Int] ?? [Int]()
        
        
        defaults = UserDefaults.standard
        self.highscoreNames = defaults.object(forKey: "names") as? [String] ?? [String]()
        if self.highscoreNames == [] {
            self.highscoreNames = ["","","","","","","","","","","",""]
        }
        if self.highscores == [] {
            self.highscores = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        }
        for index in 0...8 {
            if index != 10 {
                theHighScoresViewController.kek(score: self.highscores[index], number:index, Name: self.highscoreNames[index])
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            timeCon.constant = -200
            timercon.constant = -200
            scorecon.constant = -200
            pointscon.constant = -200
            //still need button middle
        }else {
            timeCon.constant = 0
            timercon.constant = 0
            scorecon.constant = 0
            pointscon.constant = 0
        
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

