//
//  ViewController.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/4/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var selectedQuestions:[Any]?
    
    let questions =
        ["Mathematics":
            ["description":"Did you pass the third grade?",
             "icon": "Math.png",
             "questions":
                [
                    [
                        "text": "What is 2+2?",
                        "answer": "1",
                        "answers": [
                            "4",
                            "22",
                            "An irrational number",
                            "Nobody knows"
                        ]
                    ]
                ],
            ],
         "Marvel Super Heroes":
            ["description":"Avengers, Assemble!",
             "icon": "Marvel.png",
             "questions":
                [
                    [
                        "text": "Who is Iron Man?",
                        "answer": "1",
                        "answers": [
                            "Tony Stark",
                            "Obadiah Stane",
                            "A rock hit by Megadeth",
                            "Nobody knows"
                        ]
                    ],
                    [
                        "text": "Who founded the X-Men?",
                        "answer": "2",
                        "answers": [
                            "Tony Stark",
                            "Professor X",
                            "The X-Institute",
                            "Erik Lensherr"
                            ]
                        ],
                        [
                        "text": "How did Spider-Man get his powers?",
                        "answer": "1",
                        "answers": [
                        "He was bitten by a radioactive spider",
                        "He ate a radioactive spider",
                        "He is a radioactive spider",
                        "He looked at a radioactive spider"
                        ]
                    ]
                ],
            ],
         "Science!":
            ["description":"Because SCIENCE!",
             "icon": "Science.png",
             "questions":
                [
                    [
                        "text": "What is fire?",
                        "answer": "1",
                        "answers": [
                            "One of the four classical elements",
                            "A magical reaction given to us by God",
                            "A band that hasn't yet been discovered",
                            "Fire! Fire! Fire! heh-heh"
                        ]
                    ],
                ],
            ]
        ]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let keys = Array(questions.keys)[indexPath.row]
        let subjects = questions[keys]! as [String:Any]
        cell.myTitle.text = keys
        cell.myDesc.text = subjects["description"] as! String
        cell.myImage.image = UIImage(named: subjects["icon"] as! String)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ViewControllerTableViewCell
        let key = cell.myTitle.text!
        let dictionary = questions[key]! as [String:Any]
        selectedQuestions = dictionary["questions"] as! [Any]
        performSegue(withIdentifier: "questionSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let other = segue.destination as! QuestionViewController
        other.questions = selectedQuestions
        other.questionIndex = 0
        other.score = 0
    }
    
    @IBAction func settingsAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
