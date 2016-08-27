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

func randomChoicesWith(correctValue: Int, numberOfRandomOptions: Int, randomOffset: Int) -> [QuizOption] {
    var randomChoices: [Int] = [correctValue]
    let lowerOffset = ((correctValue - randomOffset) <= 0) ? 1 : (correctValue - randomOffset)
    var upperOffset = correctValue + randomOffset

    // This check is to avoid an infinite loop in case difference between upper and lower offet is less than total number of options. That will cause an infinite loop during random options generation.
    if upperOffset - lowerOffset < numberOfRandomOptions {
        while upperOffset - lowerOffset < numberOfRandomOptions {
            upperOffset = upperOffset + 1
        }
    }
    
    while randomChoices.count < numberOfRandomOptions {
        
        let randomChoice = Int(positiveRandomNumberInRange(UInt32(lowerOffset), upperValue: UInt32(upperOffset)))
        
        if (randomChoices.contains(randomChoice) == false) {
            randomChoices.append(randomChoice)
        }
    }
    randomChoices = randomChoices.shuffle()
    
    let randomQuizOptions = randomChoices.map({
        (value: Int) -> QuizOption in
        return QuizOption(name: String(value), isCorrectOption: value == correctValue)
    })
    
    return randomQuizOptions
}