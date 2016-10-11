//
//  GameInstructionsViewModelSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class GameInstructionsViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("Testing the Game instructions view model with invalid file name") {
            
            let gameInstructionsViewModel = GameInstructionsViewModel(instructionsFileName: "Nonexistant_file")
            
            it("Game instruction view model should have blank instruction value", closure: { 
                expect(gameInstructionsViewModel.instructions.characters.count).to(equal(0))
            })
        }
        
        describe("Testing the Game instructions view model with valid file name") {
            
            let gameInstructionsViewModel = GameInstructionsViewModel(instructionsFileName: "instructions")
            
            it("Game instruction view model should have non empty instruction value", closure: {
                expect(gameInstructionsViewModel.instructions.characters.count).to(beGreaterThan(0))
            })
        }
    }
}
