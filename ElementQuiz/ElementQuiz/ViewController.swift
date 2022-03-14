//
//  ViewController.swift
//  ElementQuiz
//
//  Created by SD on 21/02/2022.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}

var mode: Mode = .flashCard
var state: State = .question

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var correctAnswerCountUI: UILabel!
    
    let elementList = ["Carbon", "Gold", "Chlorine","Sodium"]
    var currentElementIndex = 0
    var answerIsCorrect = false
    var correctAnswerCount = 0

    func updateQuizUI(){
    }
    
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "🤔🤔🤔"
        }
    }
    
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        answerLabel.text = elementList[currentElementIndex]
        updateFlashCardUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex ==
           elementList.count {
            currentElementIndex = 0
        }
        state = .question
        textField.text = ""
        updateFlashCardUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text!
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
            correctAnswerCountUI.text = String(correctAnswerCount)
        } else {
            answerIsCorrect = false
        }
        state = .answer
        updateUI()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlashCardUI()
    }
}
