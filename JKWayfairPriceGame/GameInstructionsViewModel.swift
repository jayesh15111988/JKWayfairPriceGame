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
    init() {
        if let instructions = JSONReader().readJSONFromFileWith("Instructions") as? [String: AnyObject], instructionsContent = instructions["instructions"] as? String {
            self.instructions = instructionsContent
        } else {
            self.instructions = ""
        }
    }
}