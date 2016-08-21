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
    var correctOption: String?
    
    init(title: String, options: [QuizOption], selectedOption: Int) {
        self.title = title
        self.options = options
        self.selectedOption = selectedOption == -1 ? "N/A" : String(selectedOption)
        
        for (index, option) in options.enumerate() {
            if option.isCorrectOption == true {
                self.correctOption = String(index)
                break
            }
        }
    }
}