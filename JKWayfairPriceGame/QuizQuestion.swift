//
//  QuizQuestion.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class QuizQuestion: NSObject {
    
    let title: String
    let productURL: NSURL?
    let options: [QuizOption]
    
    init(title: String, productURL: NSURL?, options: [QuizOption]) {
        self.title = title
        self.productURL = productURL
        self.options = options
        super.init()
    }
}