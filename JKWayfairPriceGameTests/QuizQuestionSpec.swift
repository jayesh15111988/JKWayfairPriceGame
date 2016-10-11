//
//  QuizQuestionSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class QuizQuestionSpec: QuickSpec {
    
    override func spec() {
        describe("Verifying the Quiz question model") { 
            it("The options value passed to the quiz model object should be identical to the value associated with model", closure: {
                let quizOptions = [QuizOption(name: "Quastion 1", isCorrectOption: true), QuizOption(name: "Quastion 2", isCorrectOption: false)]
                
                let quizQuestion = QuizQuestion(options: quizOptions)
                expect(quizQuestion.options).to(equal(quizOptions))
            })
        }
    }
}

extension QuizOption: Equatable {}

func ==(lhs: QuizOption, rhs: QuizOption) -> Bool {
    return lhs.name == rhs.name && lhs.isCorrectOption == rhs.isCorrectOption
}
