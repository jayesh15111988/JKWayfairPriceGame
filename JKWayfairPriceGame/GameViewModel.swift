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
    var selectedProduct: Product?
    var questionIndex: Int = 0
    dynamic var questionObject: QuizQuestion?
    var skipQuestionActionCommand: RACCommand?
    var finisQuizActionCommand: RACCommand?
    var viewProductOnlineActionCommand: RACCommand?
    dynamic var productWebViewerViewModel: ProductWebViewerViewModel?
    dynamic var selectedOptionIndex: Int
    
    init(products: [Product]) {
        self.products = products
        self.selectedOptionIndex = 0
        super.init()
        self.skipQuestionActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.jumpToNextQuestion()
            return RACSignal.empty()
        })
        
        self.finisQuizActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            // Finish Quiz
            return RACSignal.empty()
        })
        
        self.viewProductOnlineActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            if let productURL = self.selectedProduct?.productURL {
                self.productWebViewerViewModel = ProductWebViewerViewModel(webURL: productURL)
            }
            return RACSignal.empty()
        })
        
        RACObserve(self, keyPath: "selectedOptionIndex").skip(1).subscribeNext{ (index) in
            if let index = index as? Int {
                let selectedOption = self.questionObject?.options[index]
                print("Is correct \(selectedOption?.isCorrectOption)")
                self.jumpToNextQuestion()
            }
        }
        
        self.generateRandomProductQuiz()
    }
    
    func generateRandomProductQuiz() {
        self.selectedProduct = products[positiveRandomNumberInRange(0, upperValue: UInt32(products.count - 1))]
        if let product = self.selectedProduct {
            let randomOptions = randomChoicesWith(product.listPriceRounded.integerValue, numberOfRandomOptions: 4, randomOffset: 5)
            self.questionObject = QuizQuestion(options: randomOptions)
        }
    }
    
    func jumpToNextQuestion() {
        self.questionIndex = self.questionIndex + 1;
        self.generateRandomProductQuiz()
    }
}
