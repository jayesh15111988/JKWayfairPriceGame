//
//  GameViewModelSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/12/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class GameViewModelSpec: QuickSpec {
    
    override func spec() {
        var products: [Product] = []
        var gameViewModel: GameViewModel? = nil
        
        beforeEach { 
            let product1 = try? Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 100, "manufacturerIdentifier": 200, "manufacturerName": "Random Manufacturer", "name": "A very good product", "salePrice": 50, "sku": "SK243"])
            let product2 = try? Product(dictionary: ["availability": "Unavailable", "imageURL": "", "listPrice": 200, "manufacturerIdentifier": 9393, "manufacturerName": "Random Manufacturer 1", "name": "A very great product", "salePrice": 100, "sku": "SK343"])
            let product3 = try? Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 10000, "manufacturerIdentifier": 200, "manufacturerName": "Random Manufacturer 2", "name": "A very amazing product", "salePrice": 5000, "sku": "SK24453"])
            let product4 = try? Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 144000, "manufacturerIdentifier": 900, "manufacturerName": "Random Manufacturer 3", "name": "A very amazing product", "salePrice": 72000, "sku": "SK2445493"])
            products = [product1!, product2!, product3!, product4!]
            gameViewModel = GameViewModel(products: products)
        }
        
        describe("Verifying the initial value of parameters when GameViewModel is initialized") { 
            it("All the initial parameters of GameViewModel should have expected initial values", closure: { 
                expect(gameViewModel?.products.count).to(equal(products.count))
                expect(gameViewModel?.products).to(equal(products))
                expect(gameViewModel?.selectedOptionIndex).to(equal(0))
                expect(gameViewModel?.totalScore).to(equal(0))
                expect(gameViewModel?.selectedProduct).notTo(beNil())
                expect(gameViewModel?.answersCollection).notTo(beNil())
                expect(gameViewModel?.answersCollection.count).to(equal(0))
                expect(gameViewModel?.finisQuizActionCommand).notTo(beNil())
                expect(gameViewModel?.viewProductOnlineActionCommand).notTo(beNil())
            })
        }
        
        describe("Verifying the behavior when user skips the question") { 
            it("When user skips the question it should increase skip count and add corresponding question in answersCollection array", closure: {
                expect(gameViewModel?.skipCount).to(equal(0))
                expect(gameViewModel?.questionIndex).to(equal(0))
                expect(gameViewModel?.answersCollection.count).to(equal(0))
                gameViewModel?.skipQuestionActionCommand?.execute(nil)
                expect(gameViewModel?.skipCount).to(equal(1))
                expect(gameViewModel?.questionIndex).to(equal(1))
                expect(gameViewModel?.answersCollection.count).to(equal(1))
                if let answer = gameViewModel?.answersCollection.first {
                    expect(answer.selectedOption).to(equal("Skipped"))
                }
            })
        }
        
        describe("Verifying the behavior when user chooses to view the product online") { 
            it("When user cicks to view the product online, gameViewModel should initialize appropriate view model", closure: {
                expect(gameViewModel?.productWebViewerViewModel).to(beNil())
                gameViewModel?.viewProductOnlineActionCommand?.execute(nil)
                expect(gameViewModel?.productWebViewerViewModel).notTo(beNil())
            })
        }
        
        describe("Verifying the behavior when user selects any options for given question") { 
            it("App should behave correctly when user selects any option - Either correct or incorrect one", closure: {
                var selectedQuestionIndex = -1
                expect(gameViewModel?.answersCollection.count).to(equal(0))
                expect(gameViewModel?.questionIndex).to(equal(0))
                for (index, product) in products.enumerate() {
                    if product.categoryIdentifier == gameViewModel?.selectedProduct?.categoryIdentifier {
                        selectedQuestionIndex = index
                        break
                    }
                }
                expect(selectedQuestionIndex).toNot(equal(-1))
                gameViewModel?.selectedOptionIndex = 1
                expect(gameViewModel?.answersCollection.count).to(equal(1))
                expect(gameViewModel?.questionIndex).to(equal(1))
            })
        }
        
        describe("Verifying the behavior when user chooses to finish the quiz") { 
            it("When user decides to finish the quiz, it should switch to appropriate quiz finish state", closure: { 
                expect(gameViewModel?.finalQuizScoreViewModel).to(beNil())
                expect(gameViewModel?.enableViewInteraction).to(beTrue())
                gameViewModel?.finisQuizActionCommand?.execute(nil)
                expect(gameViewModel?.finalQuizScoreViewModel).notTo(beNil())
                expect(gameViewModel?.enableViewInteraction).to(beFalse())
            })
        }
        
        describe("Verifying the behavior when selected answer is added to the answers collection") {
            it("AnswersCollection should append an items once user makes option selection for given question", closure: { 
                expect(gameViewModel?.answersCollection.count).to(equal(0))
                gameViewModel?.addToAnswersCollectionWithSelectedOptionIndex(0)
                expect(gameViewModel?.answersCollection.count).to(equal(1))
                gameViewModel?.generateRandomProductQuiz()
                gameViewModel?.addToAnswersCollectionWithSelectedOptionIndex(3)
                expect(gameViewModel?.answersCollection.count).to(equal(2))
            })
        }
        
        describe("Verifying the handling final score") { 
            it("App should update the state based on the screen option user has chosen", closure: {
                
                // Go back
                expect(gameViewModel?.goBackToHomePage).to(beFalse())
                gameViewModel?.handleFinalScoreScreenOption(ScoreOption.FinalScoreScreenOption.GoBack)
                expect(gameViewModel?.goBackToHomePage).to(beTrue())
                
                // New game
                expect(gameViewModel?.enableViewInteraction).to(beTrue())
                gameViewModel?.handleFinalScoreScreenOption(ScoreOption.FinalScoreScreenOption.NewGame)
                expect(gameViewModel?.selectedProduct).toNot(beNil())
                
                // View Statistics
                expect(gameViewModel?.viewStatistics).to(beFalse())
                gameViewModel?.handleFinalScoreScreenOption(ScoreOption.FinalScoreScreenOption.ViewStatistics)
                expect(gameViewModel?.viewStatistics).to(beTrue())
            })
        }
        
        describe("Verifying the reset app parameters behavior") { 
            it("App should reset all parameters to initial value when reset quiz action is invoked", closure: {
                gameViewModel?.resetParameters()
                expect(gameViewModel?.selectedProduct).to(beNil())
                expect(gameViewModel?.questionIndex).to(equal(0))
                expect(gameViewModel?.skipCount).to(equal(0))
                expect(gameViewModel?.totalScore).to(equal(0))
                expect(gameViewModel?.answersCollection.count).to(equal(0))
            })
        }
    }

}
