//
//  GameInstructionsViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class GameInstructionsViewModel {
    let instructions: String
    init(instructionsFileName: String) {
        if let instructions = JSONReader().readJSONFromFileWith(instructionsFileName) as? [String: AnyObject], instructionsContent = instructions[instructionsFileName] as? String {
            self.instructions = instructionsContent
        } else {
            self.instructions = ""
        }
    }
}