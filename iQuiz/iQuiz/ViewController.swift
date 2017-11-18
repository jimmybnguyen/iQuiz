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
    
    var questions : [[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (QuizData.shared.data != nil) {
            questions = QuizData.shared.data!
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let dictionary = questions![indexPath.row] as [String:Any]
        cell.myTitle.text = dictionary["title"] as! String
        cell.myDesc.text = dictionary["desc"] as! String
        cell.myImage.image = UIImage(named: "quizicon")
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictionary = questions![indexPath.row] as [String:Any]
        selectedQuestions = dictionary["questions"] as! [[String:Any]]
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
