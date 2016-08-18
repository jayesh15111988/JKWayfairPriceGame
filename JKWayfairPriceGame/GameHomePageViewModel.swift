//
//  GameHomePageViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class GameHomePageViewModel {
    
    
    init() {
        ProductApi.sharedInstance.productsWith("419247", format: .json)
    }
}