//
//  Random.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

func negativeRandomNumberInRange(lowerValue: Int, upperValue: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) + lowerValue
}

func positiveRandomNumberInRange(lowerValue: UInt32, upperValue: UInt32) -> Int {
    return Int(arc4random_uniform(upperValue - lowerValue + 1) + lowerValue)
}

func randomChoicesWith(originalNumber: Int, numberOfRandomOptions: Int, randomOffset: Int) -> [QuizOption] {
    var randomChoices: [Int] = [originalNumber]
    
    while randomChoices.count < numberOfRandomOptions {
        
        let lowerOffset = originalNumber - randomOffset <= 0 ? 1 : originalNumber - randomOffset
        
        let randomChoice = Int(positiveRandomNumberInRange(UInt32(lowerOffset), upperValue: UInt32(originalNumber + randomOffset)))
        
        if (randomChoices.contains(randomChoice) == false) {
            randomChoices.append(randomChoice)
        }
    }
    randomChoices = randomChoices.shuffle()
    
    let randomChoicesAsString = randomChoices.map({
        (value: Int) -> QuizOption in
        return QuizOption(name: String(value), isCorrectOption: value == originalNumber)
    })
    
    return randomChoicesAsString
}