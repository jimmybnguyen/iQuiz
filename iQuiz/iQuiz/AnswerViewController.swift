//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/13/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var questions: [Any]?
    var answer: Int?
    var questionIndex: Int?
    var score: Int?
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentQuestion = questions![questionIndex!] as! [String:Any]
        let text = currentQuestion["text"] as! String
        let correctIndex = Int(currentQuestion["answer"] as! String)! - 1
        let answers = currentQuestion["answers"] as! [String]
        if answer == correctIndex {
            score! = score! + 1
            answerLabel.text = "Correct! \n"
        } else {
            answerLabel.text = "Incorrect \n"
        }
        answerLabel.text = "\(answerLabel.text!)Question: \(text)\n"
        answerLabel.text = "\(answerLabel.text!)Correct Answer: \(answers[correctIndex])"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        if (questionIndex == questions!.count - 1) {
            performSegue(withIdentifier: "resultSegue", sender: self)
        } else {
            performSegue(withIdentifier: "questionSegue", sender: self)
        }
    }
    
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        if (questionIndex == questions!.count - 1) {
            performSegue(withIdentifier: "resultSegue", sender: self)
        } else {
            performSegue(withIdentifier: "questionSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let other = segue.destination as! ResultViewController
            other.score = score
            other.questions = questions
        } else if segue.identifier == "questionSegue" {
            let other = segue.destination as! QuestionViewController
            other.questions = questions
            other.score = score
            other.questionIndex = questionIndex! + 1
        }
    }
    
}
