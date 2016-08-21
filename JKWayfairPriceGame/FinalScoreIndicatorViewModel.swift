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
    
    init(gameViewModel: GameViewModel) {
        self.finalScoreScreenOption = .GoBack
        self.gameViewModel = gameViewModel
        self.totalStats = "Total Questions: \(gameViewModel.questionIndex + 1)\n\nSkipped Questions: \(gameViewModel.skipCount)\n\nCorrect Answers: \(gameViewModel.totalScore/gameViewModel.pointsPerCorrectAnswer)\n\nTotal Score: \(gameViewModel.totalScore)\n\n"
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