//
//  ViewController.swift
//  LearnApp
//
//  Created by hyperactive on 26/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit
import AVFoundation

class ListenToSentence: UIViewController {
    
    var canPutObjInTisPointX: CGFloat = 0.0
    var canPutObjInTisPointY: CGFloat = 0.0
    var maxLine = 3
    var sentenceToCheck = ""
    var rightSentence = ""
    var buttonInLine: [Button] = []
    var buttons: [UIButton] = []
    var counterForTimer = 0
    var timer = Timer()
    var counterForWronganswers = 0
    
   @IBOutlet var firstLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterForTimer = 0
        counterForWronganswers = 0
        canPutObjInTisPointX = 0.0
        canPutObjInTisPointY = firstLine.frame.maxY + 30
        maxLine = 3
        buttonInLine = []
        buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11]
        updateWordsAndSentence()
    }
    
    func updateWordsAndSentence(){
        rightSentence = StorgeOfWordsAndSentences.giveMeRandomeSentence()
        var words = StorgeOfWordsAndSentences.randomWordsIncludingFromSentence(sentence: rightSentence)
        for i in 0..<buttons.count{
            buttons[i].setTitle(words[i], for: UIControlState.normal)
        }
    }
    
    @IBAction func talk(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: rightSentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "Hebrew")
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        timer.invalidate() // just in case this button is tapped multiple times
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @IBOutlet var button1: Button!
    @IBOutlet var button2: Button!
    @IBOutlet var button3: Button!
    @IBOutlet var button4: Button!
    @IBOutlet var button5: Button!
    @IBOutlet var button6: Button!
    @IBOutlet var button7: Button!
    @IBOutlet var button8: Button!
    @IBOutlet var button9: Button!
    @IBOutlet var button10: Button!
    @IBOutlet var button11: Button!
    
    @IBAction func word(_ sender: UIButton) {
        print(buttonInLine.count)
        let button = sender as! Button
        if button.startPosision == CGRect.zero {
            button.startPosision = sender.frame
            moveToLine(button: button)
        } else {
            removeFromLine(button: button)
        }
    }
    
    func moveToLine(button sender: Button){
        if maxLine>0{
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                sender.frame = CGRect(x: self.canPutObjInTisPointX, y: self.canPutObjInTisPointY, width:  sender.frame.width, height:  sender.frame.height)
            })
            sender.onLine = sender.frame
            canPutObjInTisPointX+=sender.frame.width + 5
            if canPutObjInTisPointX >= view.frame.maxX - 50 {
                canPutObjInTisPointX = 0.0
                canPutObjInTisPointY += sender.frame.height*2
                maxLine-=1
            }
            buttonInLine.append(sender)
        }
    }
    
    func removeFromLine( button: Button){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            button.frame = button.startPosision
        })
        orderButtons(buttontoRemove: button)
    }
    
    func orderButtons(buttontoRemove button: Button) {
        var tempararyRectForButtoReplacment = button.onLine
        if let i = buttonInLine.index(of: button) {
            button.startPosision = CGRect.zero
            buttonInLine.remove(at: i)
            if !buttonInLine.isEmpty{
                for index in i..<buttonInLine.count {
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self.buttonInLine[index].frame = tempararyRectForButtoReplacment
                    })
                    tempararyRectForButtoReplacment = buttonInLine[index].onLine
                    buttonInLine[index].onLine = buttonInLine[index].frame
                }
            }
        }
        makeNewSentence()
    }

    //MARK:- sentences:
    func makeNewSentence(){
        sentenceToCheck = ""
        canPutObjInTisPointX = 0.0
        for button in buttonInLine {
            sentenceToCheck+=(button.titleLabel?.text)!+" "
            if canPutObjInTisPointX>=view.frame.width{
                maxLine+=1
                canPutObjInTisPointX = (buttonInLine.last?.frame.minX)!
            } else {
                canPutObjInTisPointX+=button.frame.width + 5
            }
            canPutObjInTisPointY = (buttonInLine.last?.frame.minY)!
           // canPutObjInTisPointX = (buttonInLine.last?.frame.maxX)! + 5
        }
        print(sentenceToCheck)
    }
    
    // called every time interval from the timer
   @objc func timerAction() {
        counterForTimer += 1
     }
    
    @IBAction func checkIfCorrect(_ sender: UIButton) {
        makeNewSentence()
        var yourightOrYouWrong = ""
        if rightSentence+" " == sentenceToCheck {
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

