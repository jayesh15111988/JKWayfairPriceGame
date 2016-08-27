//
//  QuizAnswer.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class QuizAnswer {
    
    let title: String
    let options: [QuizOption]
    let selectedOption: String
    var correctOption: String
    var isCorrect: Bool
    
    init(title: String, options: [QuizOption], selectedOption: Int) {
        self.title = title
        self.options = options
        self.correctOption = ""
        
        self.selectedOption = selectedOption == -1 ? "Skipped" : options[selectedOption].name
        
        for (index, option) in options.enumerate() {
            if option.isCorrectOption == true {
                self.correctOption = options[index].name
                break
            }
        }
        self.isCorrect = self.correctOption == self.selectedOption
    }
}