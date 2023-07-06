//
//  ViewController.swift
//  ShrekGame
//
//  Created by Anıt Akdeniz on 6.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var shrekArray = [UIImageView] ()
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var shrek1: UIImageView!
    @IBOutlet weak var shrek2: UIImageView!
    @IBOutlet weak var shrek3: UIImageView!
    @IBOutlet weak var shrek4: UIImageView!
    @IBOutlet weak var shrek5: UIImageView!
    @IBOutlet weak var shrek6: UIImageView!
    @IBOutlet weak var shrek7: UIImageView!
    @IBOutlet weak var shrek8: UIImageView!
    @IBOutlet weak var shrek9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        shrek1.isUserInteractionEnabled = true
        shrek2.isUserInteractionEnabled = true
        shrek3.isUserInteractionEnabled = true
        shrek4.isUserInteractionEnabled = true
        shrek5.isUserInteractionEnabled = true
        shrek6.isUserInteractionEnabled = true
        shrek7.isUserInteractionEnabled = true
        shrek8.isUserInteractionEnabled = true
        shrek9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        shrek1.addGestureRecognizer(recognizer1)
        shrek2.addGestureRecognizer(recognizer2)
        shrek3.addGestureRecognizer(recognizer3)
        shrek4.addGestureRecognizer(recognizer4)
        shrek5.addGestureRecognizer(recognizer5)
        shrek6.addGestureRecognizer(recognizer6)
        shrek7.addGestureRecognizer(recognizer7)
        shrek8.addGestureRecognizer(recognizer8)
        shrek9.addGestureRecognizer(recognizer9)
        
        shrekArray = [shrek1,shrek2,shrek3,shrek4,shrek5,shrek6,shrek7,shrek8,shrek9]
        
        counter = 10
        timerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideShrek), userInfo: nil, repeats: true)
        
        hideShrek()
        
    }
    
    @objc func increaseScore() {
        score = score + 1
        currentScoreLabel.text = "Score: \(score)"
    }
    
    @objc func timerFunction() {
        
        
        if self.score > self.highScore {
            self.highScore = self.score
            highScoreLabel.text = "Highscore: \(highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
        }
        
        let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
        let alertOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            alert.dismiss(animated: true)
        }
        let alertAgain = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { _ in
            self.score = 0
            self.currentScoreLabel.text = "Score: \(self.score)"
            self.counter = 10
            self.timerLabel.text = "\(self.counter)"
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideShrek), userInfo: nil, repeats: true)
        }

        alert.addAction(alertOK)
        alert.addAction(alertAgain)
        
        timerLabel.text = "\(counter)"
        counter = counter - 1
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for shrek in shrekArray {
                shrek.isHidden = true
            }
            
            present(alert,animated: true)
        }
    }
    
    @objc func hideShrek() {
        
        for shrek in shrekArray {
            shrek.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(shrekArray.count - 1)))
        shrekArray[randomNumber].isHidden = false
    }
    
}



