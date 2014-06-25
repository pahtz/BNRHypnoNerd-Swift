//
//  BNRQuizViewController.swift
//  BNRQuiz-Swift
//
//  Created by Paul Yu on 24/6/14.
//  Copyright (c) 2014 Paul Yu. All rights reserved.
//

import UIKit

class BNRQuizViewController: UIViewController {
    var currentQuestionIndex:Int = 0
    var questions:String[]!
    var answers:String[]!
    
    @IBOutlet var answerLabel: UILabel
    @IBOutlet var questionLabel: UILabel
    
    @IBAction func showQuestion(sender: UIButton) {
        //Step to the next question
        currentQuestionIndex++
        
        //Am I past the last question?
        if (currentQuestionIndex == questions.count)
        {
            //Go back to the first question
            currentQuestionIndex = 0
        }
        
        //Get the string at that index in the questions array
        let question = questions[currentQuestionIndex]
        
        //Display the string in the question label
        questionLabel.text = question
        
        //Reset the answer label
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        //What is the answer to the current question?
        let answer = answers[currentQuestionIndex]
        
        //Display it in the answer label
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Create two arrays filled with questions and answers
        // and make the reference point to them
        questions = ["From what is cognac made?", "What is 7 +7?", "What is the capital of Vermont?"]
        
        answers = ["Grapes", "14", "Montpelier"]
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        //Set the tab bar item's title
        tabBarItem.title = "Quiz"
        //Create a UIImage from a file
        //This will use Quiz@2x.png on retina display devices
        let image = UIImage(named: "Quiz.png")
        //Put that image on the tab bar item
        tabBarItem.image = image
    }

}
