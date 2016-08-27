//
//  QuizQuestion.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class QuizQuestion: NSObject {
    
    let options: [QuizOption]
    
    init(options: [QuizOption]) {        
        self.options = options
        super.init()
    }
}