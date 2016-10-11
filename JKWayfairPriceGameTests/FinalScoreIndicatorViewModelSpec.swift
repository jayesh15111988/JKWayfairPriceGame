//
//  FinalScoreIndicatorViewModelSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class FinalScoreIndicatorViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("Verifying the final score indicator view model") {
            
            var finalScoreIndicatorViewModel: FinalScoreIndicatorViewModel? = nil
            var gameViewModel: GameViewModel? = nil
            
            beforeEach({
                let product1 = try? Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 100, "manufacturerIdentifier": 200, "manufacturerName": "Random Manufacturer", "name": "A very good product", "salePrice": 50, "sku": "SK243"])
                let product2 = try? Product(dictionary: ["availability": "Unavailable", "imageURL": "", "listPrice": 200, "manufacturerIdentifier": 9393, "manufacturerName": "Random Manufacturer 1", "name": "A very great product", "salePrice": 100, "sku": "SK343"])
                let product3 = try? Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 10000, "manufacturerIdentifier": 200, "manufacturerName": "Random Manufacturer 2", "name": "A very amazing product", "salePrice": 5000, "sku": "SK24453"])
                gameViewModel = GameViewModel(products: [product1!, product2!, product3!])
                // Mocking these values since we are not really testing the GameViewModel.
                gameViewModel?.totalScore = 20
                gameViewModel?.questionIndex = 3
                gameViewModel?.skipCount = 0
                finalScoreIndicatorViewModel = FinalScoreIndicatorViewModel(gameViewModel: gameViewModel!)
            })
            
            describe("Verifying the initial parameter values for FinalScoreIndicatorViewModel", {
                it("Initial values of model should match the expected value", closure: { 
                    expect(finalScoreIndicatorViewModel?.finalScoreScreenOption).to(equal(ScoreOption.FinalScoreScreenOption.GoBack))
                    expect(finalScoreIndicatorViewModel?.gameViewModel).toNot(beNil())
                    expect(gameViewModel).to(beIdenticalTo(finalScoreIndicatorViewModel?.gameViewModel))
                })
            })
            
            describe("Verifying the game statistics", { 
                it("Game statistics should match the expected string corresponding to the game parameters based on the user performance", closure: {
                    expect(finalScoreIndicatorViewModel?.totalStats).to(equal("Total Questions: 3 Skipped: 0\n\nCorrect: 2 / 66%\n\nTotal Score: 20"))
                })
            })
            
            describe("Verifying the back button press action", {
                it("Pressing back button should update the finalScoreScreenOption to corresponding value", closure: { 
                    finalScoreIndicatorViewModel?.goBackButtonActionCommand?.execute(nil)
                    expect(finalScoreIndicatorViewModel?.finalScoreScreenOption).to(equal(ScoreOption.FinalScoreScreenOption.GoBack))
                })
            })
            
            describe("Verifying the new game button press action", {
                it("Pressing new game button should update the finalScoreScreenOption to corresponding value", closure: {
                    finalScoreIndicatorViewModel?.newGameButtonActionCommand?.execute(nil)
                    expect(finalScoreIndicatorViewModel?.finalScoreScreenOption).to(equal(ScoreOption.FinalScoreScreenOption.NewGame))
                    
                })
            })
            
            describe("Verifying the view statistics button press action", {
                it("Pressing view statistics button should update the finalScoreScreenOption to corresponding value", closure: {
                    finalScoreIndicatorViewModel?.viewStatisticsButtonActionCommand?.execute(nil)
                    expect(finalScoreIndicatorViewModel?.finalScoreScreenOption).to(equal(ScoreOption.FinalScoreScreenOption.ViewStatistics))
                })
            })
        }
    }
}
