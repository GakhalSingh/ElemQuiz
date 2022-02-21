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

class ViewController: UIViewController {
    
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let elementList = ["Carbon", "Gold", "Chlorine","Sodium"]
    var currentElementIndex = 0
    
    func updateFlashCardUI() {
        let elementName =
           elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "🤔🤔🤔"
        }
    }

    @IBAction func showAnswer() {
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
        updateFlashCardUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFlashCardUI()
    }
    
}

