//
//  HighscoreViewController.swift
//  tappity
//
//  Created by William Harlum on 5/6 17.
//  Copyright © 2017 william.harlum. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {

    @IBOutlet weak var button1: UILabel!
    @IBOutlet weak var button2: UILabel!
    @IBOutlet weak var button3: UILabel!
    @IBOutlet weak var button4: UILabel!
    @IBOutlet weak var button5: UILabel!
    @IBOutlet weak var button6: UILabel!
    @IBOutlet weak var button7: UILabel!
    @IBOutlet weak var button8: UILabel!
    @IBOutlet weak var button9: UILabel!
    @IBOutlet weak var button10: UILabel!

    
    func kek(score: Int, number: Int, Name: String) {
        let buttonarray = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10]
        buttonarray[number]?.text = ("\(Name) \(score)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
