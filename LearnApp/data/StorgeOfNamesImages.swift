//
//  StorgeOfNamesImages.swift
//  LearnApp
//
//  Created by hyperactive on 28/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit

class StorgeOfNamesImages {
    
    static var names = ["dog","water","love","wine","cat","house","family"]
    
    class func giveMeRandomeObject() -> String {
        return StorgeOfNamesImages.names[Int(arc4random_uniform(UInt32(StorgeOfNamesImages.names.count)))]
    }
    
    class func getImageByName(nameOfObject: String)-> UIImage? {
        if let image = ImageStore.image(forKey: nameOfObject){
            return image
        }
        print("error:can't find Image With This Name!")
        return nil
    }
    
    class func randomWordsIncludingCurrentObject(object:String)->[String]{
        var allWords:[String] = []
        while allWords.count < 4 {
            let word = giveMeRandomeObject()
            if object != word && allWords.index(of: word) == nil{
                allWords.append(word)
            }
        }
        allWords[Int(arc4random_uniform(UInt32(4)))] = object
        print(allWords)
        return allWords
    }
    
  
    
    
    
}
