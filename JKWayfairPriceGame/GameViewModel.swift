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
    
    let pointsPerCorrectAnswer = 10
    let products: [Product]
    var selectedProduct: Product?
    var questionIndex: Int = 0
    var skipCount: Int = 0
    var totalScore: Int
    
    dynamic var enableViewInteraction: Bool = true
    dynamic var goBackToHomePage: Bool = false
    dynamic var viewStatistics: Bool = false
    dynamic var questionObject: QuizQuestion?
    var skipQuestionActionCommand: RACCommand?
    var finisQuizActionCommand: RACCommand?
    var viewProductOnlineActionCommand: RACCommand?
    dynamic var productWebViewerViewModel: ProductWebViewerViewModel?
    dynamic var finalQuizScoreViewModel: FinalScoreIndicatorViewModel?
    dynamic var selectedOptionIndex: Int
    
    init(products: [Product]) {
        self.products = products
        self.selectedOptionIndex = 0
        self.totalScore = 0

        super.init()
        self.skipQuestionActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.skipCount = self.skipCount + 1
            self.jumpToNextQuestion()
            return RACSignal.empty()
        })
        
        self.finisQuizActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.resetParameters()
            self.finalQuizScoreViewModel = FinalScoreIndicatorViewModel(gameViewModel: self)
            self.enableViewInteraction = false
            RACObserve(self.finalQuizScoreViewModel, keyPath: "finalScoreScreenOption").skip(1).subscribeNext {
                (finalScoreScreenOption) in
                if let finalScoreScreenOption = self.finalQuizScoreViewModel?.finalScoreScreenOption {
                    self.handleFinalScoreScreenOption(finalScoreScreenOption)
                }
            }
            return RACSignal.empty()
        })
        
        self.viewProductOnlineActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            if let selectedProduct = self.selectedProduct {
                self.productWebViewerViewModel = ProductWebViewerViewModel(product: selectedProduct)
            }
            return RACSignal.empty()
        })
        
        RACObserve(self, keyPath: "selectedOptionIndex").skip(1).subscribeNext{ (index) in
            if let index = index as? Int {
                let selectedOption = self.questionObject?.options[index]
                self.totalScore = selectedOption?.isCorrectOption == true ? self.totalScore + self.pointsPerCorrectAnswer : self.totalScore
                self.jumpToNextQuestion()
            }
        }
        
        self.generateRandomProductQuiz()
    }
    
    func handleFinalScoreScreenOption(option: ScoreOption.FinalScoreScreenOption) {
        switch option {
            case .GoBack:
                self.goBackToHomePage = true
            case .NewGame:
                self.enableViewInteraction = true
                self.generateRandomProductQuiz()
            case .ViewStatistics:
                self.viewStatistics = true
                self.generateRandomProductQuiz()
        }
    }
    
    func generateRandomProductQuiz() {
        self.selectedProduct = products[positiveRandomNumberInRange(0, upperValue: UInt32(products.count - 1))]
        if let product = self.selectedProduct {
            let randomOptions = randomChoicesWith(product.listPriceRounded.integerValue, numberOfRandomOptions: 4, randomOffset: priceOptionsOffsetForScore(self.totalScore))
            self.questionObject = QuizQuestion(options: randomOptions)
        }
    }
    
    func jumpToNextQuestion() {
        self.questionIndex = self.questionIndex + 1
        self.generateRandomProductQuiz()
    }
    
    func priceOptionsOffsetForScore(score: Int) -> Int {
        
        let percentageCorrect = Double(score/pointsPerCorrectAnswer)/Double(self.questionIndex + 1)
        var optionsOffsetFromOriginalPrice = 0
        
        switch percentageCorrect {
        case 0..<0.4:
            optionsOffsetFromOriginalPrice = 12
        case 0.4..<0.7:
            optionsOffsetFromOriginalPrice = 8
        case 0.7..<1.0:
            optionsOffsetFromOriginalPrice = 4
        default:
            optionsOffsetFromOriginalPrice = 2
        }
    
        return optionsOffsetFromOriginalPrice
    }
    
    func resetParameters() {
        selectedProduct = nil
        questionIndex = 0
        skipCount = 0
        totalScore = 0
    }
}