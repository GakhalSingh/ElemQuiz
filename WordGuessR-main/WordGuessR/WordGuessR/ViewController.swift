//
//  ViewController.swift
//  WordGuessR
//
//  Created by SD on 14/03/2022.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var loadingBar: UIProgressView!
    
    @IBOutlet weak var redMode: UIButton!
    @IBOutlet weak var greenMode: UIButton!
    @IBOutlet weak var yellowMode: UIButton!
    @IBOutlet weak var blueMode: UIButton!
    @IBOutlet weak var orangeMode: UIButton!
    
    var quizQuestions: [QuizQuestion] = []
    var filteredQuestions: [QuizQuestion] = []
    var hasLoaded = false
    var color = "red"

    enum currentCategory {
        case redMode
        case greenMode
        case yellowMode
        case blueMode
        case orangeMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocalQuizData()
    }
    
    @IBAction func selectMode(_ sender: UIButton!) {
        switch sender {
        case redMode:
            print("red")
            filteredQuestions = quizQuestions.filter { $0.category == .red }
        case greenMode:
            print("green")
            filteredQuestions = quizQuestions.filter { $0.category == .green }
        case yellowMode:
            print("yellow")
            filteredQuestions = quizQuestions.filter { $0.category == .yellow }
        case blueMode:
            print("blue")
            filteredQuestions = quizQuestions.filter { $0.category == .blue }
        case orangeMode:
            print("orange")
        default:
            break;
        }
    }
    
    @IBAction func redClick(_ sender: UIButton) {
        color = "red";
        filteredQuestions = quizQuestions.filter { $0.category == .red }
        filteredQuestions.shuffle()
        performSegue(withIdentifier: "showQuestions", sender: nil)
    }
    
    @IBAction func greenClick(_ sender: Any) {
        color = "green";
        filteredQuestions = quizQuestions.filter { $0.category == .green }
        filteredQuestions.shuffle()
        performSegue(withIdentifier: "showQuestions", sender: nil)
    }
    
    @IBAction func yellowClick(_ sender: Any) {
        color = "yellow";
        filteredQuestions = quizQuestions.filter { $0.category == .yellow }
        filteredQuestions.shuffle()
        performSegue(withIdentifier: "showQuestions", sender: nil)
    }
    
    @IBAction func blueClick(_ sender: Any) {
        color = "blue";
        filteredQuestions = quizQuestions.filter { $0.category == .blue }
        filteredQuestions.shuffle()
        performSegue(withIdentifier: "showQuestions", sender: nil)
    }
    
    @IBAction func orangeClick(_ sender: Any) {
        color = "orange";
        filteredQuestions = quizQuestions.filter { $0.category == .orange }
        filteredQuestions.shuffle()
        performSegue(withIdentifier: "showQuestions", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       if segue.identifier == "showQuestions",
          let questionsViewController = segue.destination as? QuestionsViewController {
           questionsViewController.filteredQuestions = self.filteredQuestions;
       }
    }
    
    func getLocalQuizData() {
        if let localData = self.readLocalFile(forName: "localQuizData") {
            self.parse(jsonData: localData)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
            self.quizQuestions = decodedData
        } catch {
            print("decode error")
        }
    }
}
