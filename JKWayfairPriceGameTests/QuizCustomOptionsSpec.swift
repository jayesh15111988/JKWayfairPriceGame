//
//  QuizCustomOptionsSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class QuizCustomOptionsSpec: QuickSpec {
    
    override func spec() {
        describe("Verifying the custom quiz options model") {
            
            it("Verifying the model behavior with low input score", closure: { 
                let customQuizOption = QuizCustomOptions(score: 0.3)
                expect(customQuizOption.priceOptionsOffset()).to(equal(12))
                expect(customQuizOption.textColor()).to(equal(Appearance.lowScoreColor()))
            })
            
            it("Verifying the model behavior with medium input score", closure: {
                let customQuizOption = QuizCustomOptions(score: 0.6)
                expect(customQuizOption.priceOptionsOffset()).to(equal(8))
                expect(customQuizOption.textColor()).to(equal(Appearance.mediumScoreColor()))
            })
            
            it("Verifying the model behavior with high input score", closure: {
                let customQuizOption = QuizCustomOptions(score: 0.9)
                expect(customQuizOption.priceOptionsOffset()).to(equal(4))
                expect(customQuizOption.textColor()).to(equal(Appearance.highScoreColor()))
            })
            
            it("Verifying the model behavior with perfect input score", closure: {
                let customQuizOption = QuizCustomOptions(score: 1.0)
                expect(customQuizOption.priceOptionsOffset()).to(equal(2))
                expect(customQuizOption.textColor()).to(equal(Appearance.perfectScoreColor()))
            })
            
        }
    }
}
