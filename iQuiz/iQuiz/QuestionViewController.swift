//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/12/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var Question: UILabel!
    @IBOutlet var Answers: [UIButton]!
    
    var questions: [Any]?
    var questionIndex: Int?
    var score: Int?
    
    var selectedOption: Int = -1 //no answer selected initially
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentNode = questions![questionIndex!] as! [String:Any]
        let currentQuestion = currentNode["text"] as! String
        let currentOptions = currentNode["answers"] as! [String]
        Question.text = currentQuestion
        
        for i in 0...(Answers.count - 1) {
            Answers[i].setTitle(currentOptions[i], for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "answerSegue" {
            let other = segue.destination as! AnswerViewController
            other.score = score
            other.questions = questions
            other.answer = selectedOption
            other.questionIndex = questionIndex
        }
        
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        if (selectedOption != -1) { //an answer was selected
            performSegue(withIdentifier: "answerSegue", sender: self)
        }
    }
    
    @IBAction func selectOption(_ sender: UIButton) {
        sender.backgroundColor = UIColor.black
        if (selectedOption != -1) { //an answer was selected
            Answers[selectedOption].backgroundColor = UIColor.darkGray
        }
        selectedOption = Answers.index(of: sender)!
    }
    
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        if (selectedOption != -1) { //an answer was selected
            performSegue(withIdentifier: "answerSegue", sender: self)
        }
    }
}
