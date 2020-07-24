//
//  StorgeOfWords.swift
//  LearnApp
//
//  Created by hyperactive on 27/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//


import Foundation

class StorgeOfWordsAndSentences {
    
    static var words = ["how","are","you","feeling","today","with","korner","shape","babels","brock","yes","no","hot","cold","why","before","after","later","just","if","who","i","am","a","the","have","has","dog"]
    
    static var sentences = ["how are you feeling today", "who am i", "yes i have a dog","cold today"]
    
    class func giveMeRandomeSentence()-> String {
        return StorgeOfWordsAndSentences.sentences[Int(arc4random_uniform(UInt32(StorgeOfWordsAndSentences.sentences.count)))]
    }
    
    class func wordsForThisSentence(sentence: String)-> [String]{
        var words:[String] = []
        var word = ""
        for char in sentence{
            if char != " "{
                word += "\(char)"
            } else {
                words.append(word)
                word = ""
            }
        }
        words.append(word)
        return words
    }
    
    class func randomWordsIncludingFromSentence(sentence:String)->[String]{
        let wordsInSentence = StorgeOfWordsAndSentences.wordsForThisSentence(sentence: sentence)
        var allWords:[String] = []
        var counter = 11
        var anotherWords = false
        repeat{
            for word in StorgeOfWordsAndSentences.words{
                if counter > 0{
                    if wordsInSentence.index(of: word) != nil{
                        allWords.append(word)
                        counter-=1
                    }
                    if anotherWords {
                        allWords.append(word)
                        counter-=1
                        continue
                    }
                    if allWords.count == wordsInSentence.count{
                        anotherWords = true
                        continue
                    }
                }
            }
            counter=11
                }while allWords.count < 11
        return allWords
    }
}
