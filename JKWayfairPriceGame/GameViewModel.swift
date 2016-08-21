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
    var answersCollection: [QuizAnswer]
    
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
        self.answersCollection = []
        
        super.init()
        self.skipQuestionActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.skipCount = self.skipCount + 1
            self.addToAnswersCollectionWithSelectedOptionIndex(-1)
            self.jumpToNextQuestion()
            return RACSignal.empty()
        })
        
        self.finisQuizActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
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
                self.addToAnswersCollectionWithSelectedOptionIndex(index)
                self.jumpToNextQuestion()
            }
        }
        
        self.generateRandomProductQuiz()
    }
    
    func addToAnswersCollectionWithSelectedOptionIndex(index: Int) {
        if let selectedProduct = self.selectedProduct, questionObject = self.questionObject {
            self.answersCollection.append(QuizAnswer(title: selectedProduct.name, options: questionObject.options, selectedOption: index))
        }
    }
    
    func handleFinalScoreScreenOption(option: ScoreOption.FinalScoreScreenOption) {
        switch option {
            case .GoBack:
                self.goBackToHomePage = true
            case .NewGame:
                self.resetViewWithNewQuiz()
            case .ViewStatistics:
                self.viewStatistics = true
                self.resetViewWithNewQuiz()
        }
    }
    
    func resetViewWithNewQuiz() {
        self.enableViewInteraction = true
        self.resetParameters()
        self.generateRandomProductQuiz()
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
        return QuizCustomOptions(score: percentageCorrect).priceOptionsOffset()
    }
    
    func resetParameters() {
        selectedProduct = nil
        questionIndex = 0
        skipCount = 0
        totalScore = 0
        answersCollection = []
    }
}