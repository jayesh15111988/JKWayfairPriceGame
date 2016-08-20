//
//  GameViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import CoreData
import ReactiveCocoa

class GameViewModel: NSObject {
    
    let products: [Product]
    var questionIndex: Int = 0
    dynamic var questionObject: QuizQuestion?
    var skipQuestionActionCommand: RACCommand?
    
    init(products: [Product]) {
        self.products = products
        super.init()
        
        self.skipQuestionActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.jumpToNextQuestion()
            return RACSignal.empty()
        })
        self.generateRandomProductQuiz()
    }
    
    func generateRandomProductQuiz() {
        let product = products[positiveRandomNumberInRange(0, upperValue: UInt32(products.count - 1))]
        let randomOptions = randomChoicesWith(product.listPriceRounded.integerValue, numberOfRandomOptions: 4, randomOffset: 5)        
        self.questionObject = QuizQuestion(title: product.name, productURL: product.imageURL, options: randomOptions)
    }
    
    func jumpToNextQuestion() {
        self.questionIndex = self.questionIndex + 1;
        self.generateRandomProductQuiz()
    }
}
