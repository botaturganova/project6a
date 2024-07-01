//
//  ViewController.swift
//  project 2.6
//
//  Created by bota on 06.03.2024.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        button1.imageView?.contentMode = .scaleToFill
        
        title = "\(countries[correctAnswer].uppercased() )"
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionCount += 1
    
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[correctAnswer].uppercased())"
            score -= 1
        }
        
        if questionCount == 10 {
               showFinalScore()
           } else {
               askQuestion()
           }
       }
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    func showFinalScore() {
        let finalScoreAlert = UIAlertController(title: "Game Over", message: "Your final score is \(score).", preferredStyle: .alert)
        finalScoreAlert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        present(finalScoreAlert, animated: true, completion: nil)
    }

    func restartGame() {
        score = 0
        questionCount = 0
        askQuestion()
    }
         override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
         }
     

@objc func showScoreTapped() {
     let scoreAlert = UIAlertController(title: "Current Score", message: "Your current score is \(score).", preferredStyle: .alert)
     scoreAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
     present(scoreAlert, animated: true, completion: nil)
 }
 
 override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     setupNavigationBar()
 }
 
 func setupNavigationBar() {
     let showScoreButton = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScoreTapped))
     navigationItem.rightBarButtonItem = showScoreButton
 }
}
