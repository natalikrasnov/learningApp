//
//  ImageStore.swift
//  LearnApp
//
//  Created by hyperactive on 29/11/2018.
//  Copyright © 2018 hyperactive. All rights reserved.
//

import UIKit


class ImageStore {
    
    class func imageURL(forKey key: String) -> URL? {
        let documentsPath1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath1.appendingPathComponent(key)
        do
        {
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
            print(logsPath!)
            return logsPath!
        }
        catch let error as NSError
        {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        return nil
    }
    
    class func setImage(_ image: UIImage, forKey key: String) {
        print(key)
        if let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image)  {
            let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL
            do {
                try data.write(to: (directory?.appendingPathComponent("\(key).png")!)!)
                print("saved")
            } catch {
                print(error.localizedDescription)
                print("error")
            }
        }
    }
    
    class func image(forKey key: String) -> UIImage? {
        print(key)
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("\(key).png").path)
        }
        return nil
    }
    
    class func deleteImage(forKey key: String) {
        if let url = ImageStore.imageURL(forKey: key){
            do {
                try FileManager.default.removeItem(at: url)
            } catch let deletError {
                print("Error removing the image from disk: \(deletError)")
            }
        }else{
            print("error: no such path")
        }
    }
}

