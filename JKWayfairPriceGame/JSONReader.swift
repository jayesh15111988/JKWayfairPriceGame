//
//  JSONReader.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class JSONReader {
    func readJSONFromFileWith(name: String) -> AnyObject? {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                    return json
                } catch let error as NSError {
                    print("Failed to convert JSON data into container. Failed with error \(error.localizedDescription)")
                }
            } catch let error as NSError {
                print("Failed to read json from file. Failed with error \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename or path \(name)")
        }
        return nil
    }
}