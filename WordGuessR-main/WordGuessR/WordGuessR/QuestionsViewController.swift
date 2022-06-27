//
//  QuestionsViewController.swift
//  WordGuessR
//
//  Created by SD on 04/04/2022.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var questionAnswer: UILabel!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var quizModeSelector: UISegmentedControl!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var filteredQuestions: [QuizQuestion] = []
    var currentQuestionIndex = 0
    var activatedMode = 0
    var correctAnswerCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isHidden = true
    }
    
    @IBAction func selectCurrentMode(_ sender: Any) {
        if quizModeSelector.selectedSegmentIndex == 1 {
            activatedMode = 1
        }
        else if quizModeSelector.selectedSegmentIndex == 0 {
            activatedMode = 0
        }
    }
    
    func newQuestion() {
        currentQuestion.text = filteredQuestions[currentQuestionIndex].question
        questionAnswer.text = "🤔🤔🤔"
        nextQuestionButton.isEnabled = false
        textField.text = " "
        textField.isEnabled = true
        quizModeSelector.isHidden = true
        if activatedMode == 1 {
            textField.isHidden = true
        }
        if activatedMode == 0 {
            textField.isHidden = false
        }
        counterLabel.text = " "
    }
    
    func displayAnswer(){
        questionAnswer.text = filteredQuestions[currentQuestionIndex].answer
        nextQuestionButton.isEnabled = true
        textField.isEnabled = false
        if  activatedMode == 1 || textField.text! == filteredQuestions[currentQuestionIndex].answer {
            correctAnswerCount += 1
            counterLabel.text = String(correctAnswerCount)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        textField.isEnabled = false
        if textFieldContents.lowercased() == filteredQuestions[currentQuestionIndex].answer.lowercased() {
            correctAnswerCount += 1
            counterLabel.text = String(correctAnswerCount)
        } else {
            counterLabel.text = "Oops, dat is het niet!"
            newQuestion()
            return false
        }
        nextQuestionButton.isEnabled = true
        newQuestion()
        return true
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        displayAnswer()
        showAnswerButton.isEnabled = false
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        currentQuestionIndex += 1
        if currentQuestionIndex == filteredQuestions.count {
            currentQuestionIndex = 0
        }
        newQuestion()
        showAnswerButton.isEnabled = true
        infoLabel.text = ""
    }
}
