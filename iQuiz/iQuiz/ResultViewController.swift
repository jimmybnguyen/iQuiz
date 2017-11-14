//
//  ResultViewController.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/13/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var questions: [Any]?
    var score: Int?
    var percent = 0.0

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        percent = Double(score!) / Double(questions!.count)
        if percent == 1.0 {
            resultLabel.text = "Perfect score!\n\(score!)/ \(questions!.count)"
        } else if percent >= 0.75 {
            resultLabel.text = "Good score!\n\(score!)/ \(questions!.count)"
        } else if percent >= 0.50 {
            resultLabel.text = "Alright score\n\(score!)/ \(questions!.count)"
        } else {
            resultLabel.text = "Do better next time!\n\(score!)/ \(questions!.count)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
