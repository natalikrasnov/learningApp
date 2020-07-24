//
//  ChooseCorrectSentence.swift
//  LearnApp
//
//  Created by hyperactive on 29/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit

class ChooseCorrectSentence: UIViewController {
    
    var rightSentence = ""
    var counterForTimer = 0
    var timer = Timer()
    var counterForWronganswers = 0
    var allAcsessoryLables: [UILabel] = []
    var allSentences: [UILabel] = []
    var allViews:[UIView] = []

    @IBOutlet var sentenceLable: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        counterForTimer += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightSentence = StorgeOfWordsAndSentences.giveMeRandomeSentence()
        counterForTimer = 0
        counterForWronganswers = 0
        allSentences = [sentence1,sentence2,sentence3]
        allAcsessoryLables = [acssesoryLable1,acssesoryLable2,acssesoryLable3]
        allViews = [view1,view2,view3]
        updatesentenses()
    }
    
    func updatesentenses(){
        sentenceLable.text = rightSentence
        var sentences:[String] = []
        while sentences.count < 3 {
            let sentence = StorgeOfWordsAndSentences.giveMeRandomeSentence()
            if rightSentence != sentence && sentences.index(of: sentence) == nil{
                sentences.append(sentence)
            }
        }
        sentences[Int(arc4random_uniform(UInt32(3)))] = rightSentence
        for index in 0..<allSentences.count{
            allSentences[index].text! = sentences[index]
        }
    }
    
    @IBOutlet var acssesoryLable1: UILabel!
    @IBOutlet var acssesoryLable2: UILabel!
    @IBOutlet var acssesoryLable3: UILabel!

    @IBOutlet var sentence1: UILabel!
    @IBOutlet var sentence2: UILabel!
    @IBOutlet var sentence3: UILabel!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    
    @IBAction func lableButton(_ sender: UIButton) {
        print(sender.tag)
        for index in 0..<allAcsessoryLables.count{
            allAcsessoryLables[index].text! = "○"
        }
        allAcsessoryLables[sender.tag-1].text = "◉"
        
    }
    
    @IBAction func checkIfCorrect(_ sender: UIButton) {
        for index in 0..<allAcsessoryLables.count{
            if allAcsessoryLables[index].text! == "◉"{
                if allSentences[index].text==rightSentence{
                    allViews[index].backgroundColor = UIColor.green
                    timer.invalidate()
                    print("time: \(counterForTimer)")
                    print("Wrong answers: \(counterForWronganswers)")
                }else {
                    allViews[index].backgroundColor = UIColor.red
                    counterForWronganswers += 1
                }
            }
        }
    }
    
}
