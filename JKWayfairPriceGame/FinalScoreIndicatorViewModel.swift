//
//  FinalScoreIndicatorViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ScoreOption: NSObject {
    @objc
    enum FinalScoreScreenOption: Int {
        case GoBack
        case NewGame
        case ViewStatistics
    }
}

class FinalScoreIndicatorViewModel: NSObject {
    
    dynamic var finalScoreScreenOption: ScoreOption.FinalScoreScreenOption
    var goBackButtonActionCommand: RACCommand?
    var newGameButtonActionCommand: RACCommand?
    var viewStatisticsButtonActionCommand: RACCommand?
    let gameViewModel: GameViewModel
    let totalStats: String
    let finalScoreLabelTextColor: UIColor
    
    init(gameViewModel: GameViewModel) {
        self.finalScoreScreenOption = .GoBack
        self.gameViewModel = gameViewModel
        let numberOfCorrectAnswers = gameViewModel.totalScore/gameViewModel.pointsPerCorrectAnswer
        let totalNumberOfQuestions = gameViewModel.questionIndex
        var fractionAnswersCorrect: Double = 0
        if (totalNumberOfQuestions > 0) {
            fractionAnswersCorrect = Double(numberOfCorrectAnswers)/Double(totalNumberOfQuestions)
        }
        
        let percentageAnswersCorrect = Int(fractionAnswersCorrect * 100)
        self.finalScoreLabelTextColor = QuizCustomOptions(score: fractionAnswersCorrect).textColor()
         
        self.totalStats = "Total Questions: \(totalNumberOfQuestions) Skipped: \(gameViewModel.skipCount)\n\nCorrect: \(numberOfCorrectAnswers) / \(percentageAnswersCorrect)%\n\nTotal Score: \(gameViewModel.totalScore)"
        super.init()
        
        self.goBackButtonActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.finalScoreScreenOption = .GoBack
            return RACSignal.empty()
        })
        
        self.newGameButtonActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.finalScoreScreenOption = .NewGame
            return RACSignal.empty()
        })
        
        self.viewStatisticsButtonActionCommand = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.finalScoreScreenOption = .ViewStatistics
            return RACSignal.empty()
        })
    }
}