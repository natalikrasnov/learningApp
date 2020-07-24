//
//  WritethisTranslate.swift
//  LearnApp
//
//  Created by hyperactive on 29/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit

class WritethisTranslate: UIViewController {
    
    var counterForTimer = 0
    var timer = Timer()
    var counterForWronganswers = 0
    var rightSentence = ""
    
    @IBOutlet var sentenceLable: UILabel!
    @IBOutlet var textFieldView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        counterForTimer += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterForTimer = 0
        counterForWronganswers = 0
        rightSentence = StorgeOfWordsAndSentences.giveMeRandomeSentence()
        sentenceLable.text = rightSentence
    }

    @IBAction func checkIfCorrect(_ sender: UIButton) {
        var yourightOrYouWrong = ""
        if textFieldView.text! == rightSentence{
            yourightOrYouWrong = "yay, you are right"
            timer.invalidate()
            print("time: \(counterForTimer)")
            print("Wronganswers: \(counterForWronganswers)")
        }else{
            yourightOrYouWrong = "oh no, you are wrong"
            counterForWronganswers += 1
        }
        let alertController = UIAlertController(title: yourightOrYouWrong, message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        alertController.dismiss(animated: true, completion: nil)
    }

    
}
