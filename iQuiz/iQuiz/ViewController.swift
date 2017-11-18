//
//  ViewController.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/4/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    static let shared = ViewController()
    
    var selectedQuestions:[Any]?
    var questions : [[String:Any]]?
    var sourceURL: String = ""
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var source: UITextField!
    @IBOutlet weak var table: UITableView!
    
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
        var imageTitle = dictionary["title"] as! String
        imageTitle = imageTitle + ".png"
        cell.myImage.image = UIImage(named: imageTitle)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictionary = questions![indexPath.row] as [String:Any]
        selectedQuestions = dictionary["questions"] as! [[String:Any]]
        performSegue(withIdentifier: "questionSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(table)
        if (segue.identifier == "showSettings") {
            let popoverViewController = segue.destination
            popoverViewController.popoverPresentationController?.delegate = self
        } else {
            let other = segue.destination as! QuestionViewController
            other.questions = selectedQuestions
            other.questionIndex = 0
            other.score = 0
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    @IBAction func refreshData(_ sender: Any) {
        sourceURL = source.text!
        QuizData.shared.load(sourceURL)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
