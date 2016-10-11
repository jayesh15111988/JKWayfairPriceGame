//
//  QuizAnswerSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class QuizAnswerSpec: QuickSpec {
    
    override func spec() {
        describe("Verifying the behavior of QuizAnswer object") {
            it("After initializing QuizAnswer should have valid initial values", closure: {
                let options = [QuizOption(name: "Quastion 1", isCorrectOption: true), QuizOption(name: "Quastion 2", isCorrectOption: false), QuizOption(name: "Quastion 3", isCorrectOption: false)]
                let quizAnswer = QuizAnswer(title: "Answer", options: options, selectedOption: 1)
                expect(quizAnswer.title).to(equal("Answer"))
                expect(quizAnswer.options).to(equal(options))
                expect(quizAnswer.correctOption).to(equal("Quastion 1"))
            })
            
            it("Quiz answer should correctly set the index of correct option among the provided input options", closure: {
                let options = [QuizOption(name: "Quastion 1", isCorrectOption: false), QuizOption(name: "Quastion 2", isCorrectOption: false), QuizOption(name: "Quastion 3", isCorrectOption: true)]
                let quizAnswer = QuizAnswer(title: "Answer", options: options, selectedOption: 1)
                expect(quizAnswer.correctOption).to(equal("Quastion 3"))
            })
            
            it("Quiz answer should correctly output if the option user has selected in the correct one", closure: {
                let options = [QuizOption(name: "Quastion 1", isCorrectOption: false), QuizOption(name: "Quastion 2", isCorrectOption: false), QuizOption(name: "Quastion 3", isCorrectOption: true)]
                let quizAnswer = QuizAnswer(title: "Answer", options: options, selectedOption: 2)
                expect(quizAnswer.isCorrect).to(beTrue())
            })
            
            it("Quiz answer should correctly indicate if user has skipped any question", closure: {
                let options = [QuizOption(name: "Quastion 1", isCorrectOption: false), QuizOption(name: "Quastion 2", isCorrectOption: false), QuizOption(name: "Quastion 3", isCorrectOption: true)]
                let quizAnswer = QuizAnswer(title: "Answer", options: options, selectedOption: -1)
                expect(quizAnswer.selectedOption).to(equal("Skipped"))
            })
        }
    }
}
