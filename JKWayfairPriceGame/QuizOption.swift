//
//  QuizOption.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class QuizOption {
    let name: String
    let isCorrectOption: Bool
    init(name: String, isCorrectOption: Bool) {
        self.name = name
        self.isCorrectOption = isCorrectOption
    }
}