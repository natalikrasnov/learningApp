//
//  TapOnImage.swift
//  LearnApp
//
//  Created by hyperactive on 28/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit

class TapOnImage: UIViewController {
    
    var objectName = ""
    var allViews:[UIView] = []
    var allAcssesoryLabels:[UILabel] = []
    var allNameLabels:[UILabel] = []
    var allImageViews:[UIImageView] = []
    var randomNames:[String] = []
    
    var counterForTimer = 0
    var timer = Timer()
    var counterForWronganswers = 0

    @IBOutlet var witchOfLable: UILabel!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    
    @IBOutlet var name1: UILabel!
    @IBOutlet var name2: UILabel!
    @IBOutlet var name3: UILabel!
    @IBOutlet var name4: UILabel!
    
    @IBOutlet var acssesoryLable1: UILabel!
    @IBOutlet var acssesoryLable2: UILabel!
    @IBOutlet var acssesoryLable3: UILabel!
    @IBOutlet var acssesoryLable4: UILabel!
    
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
        allViews = [view1,view2,view3,view4]
        allAcssesoryLabels = [acssesoryLable1,acssesoryLable2,acssesoryLable3,acssesoryLable4]
        allNameLabels = [name1,name2,name3,name4]
        allImageViews = [image1,image2,image3,image4]
        updateNamesLabls()
        updateImages()
    }
    
    func updateImages(){
        for index in 0..<allImageViews.count{
            allImageViews[index].image = StorgeOfNamesImages.getImageByName(nameOfObject: randomNames[index])
        }
    }
    
    func updateNamesLabls(){
        objectName = StorgeOfNamesImages.giveMeRandomeObject()
        randomNames = StorgeOfNamesImages.randomWordsIncludingCurrentObject(object: objectName)
        witchOfLable.text! = "Which Of These Is '\(objectName)'?"
        for index in 0..<allNameLabels.count{
            allNameLabels[index].text = randomNames[index]
        }
    }
 
    @IBAction func ViewButton(_ sender: UIButton) {
        print(sender.tag)
        for index in 0..<allAcssesoryLabels.count{
            allAcssesoryLabels[index].text! = "○"
        }
        allAcssesoryLabels[sender.tag-1].text = "◉"
    }
    
    @IBAction func checkIfCorrect(_ sender: UIButton) {
        for index in 0..<allAcssesoryLabels.count{
            if allAcssesoryLabels[index].text! == "◉"{
                if allNameLabels[index].text==objectName{
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
