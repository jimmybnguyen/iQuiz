//
//  Data.swift
//  iQuiz
//
//  Created by Jimmy Nguyen on 11/16/17.
//  Copyright © 2017 Jimmy B Nguyen. All rights reserved.
//

import UIKit

class QuizData: NSObject {
    
    static let shared = QuizData()
    var urlSource: String = "https://tednewardsandbox.site44.com/questions.json"
    var data: [[String:Any]]?
    var fileURL : URL?
    
    override init() {
        super.init()
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        fileURL = DocumentDirURL.appendingPathComponent("quiz-data").appendingPathExtension("json")
        load(ViewController.shared.sourceURL)
    }
    
    func load(_ newSource: String) {
        do {
            var content: NSData?
            if (newSource != "") {
                content = NSData(contentsOf: URL(string: newSource)!)
            } else {
                 content = NSData(contentsOf: URL(string: urlSource)!)
            }
            if (content == nil) {
                do {
                    content = try NSData(contentsOf: fileURL!)
                } catch {
                    print(error)
                }
            }
            if (content != nil) {
                data = try JSONSerialization.jsonObject(with: content as! Data, options: []) as! [[String:Any]]
                save(content!)
            }
        } catch {
            print(error)
        }
    }
    
    func save(_ content:NSData){
        do {
            if let questions = String(data: content as Data, encoding: String.Encoding.utf8) {
                try questions.write(to: fileURL!, atomically: true, encoding: String.Encoding.utf8)
            }
        } catch {
            print(error)
        }
    }
}
