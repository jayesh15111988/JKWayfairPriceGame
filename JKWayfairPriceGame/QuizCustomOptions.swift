//
//  QuizCustomizer.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class QuizCustomOptions {
    let score: Double
    
    init(score: Double) {
        self.score = score
    }
    
    func priceOptionsOffset() -> Int {
        
        var optionsOffsetFromOriginalPrice: Int
        switch self.score {
            case 0..<0.4:
                optionsOffsetFromOriginalPrice = 12
            case 0.4..<0.7:
                optionsOffsetFromOriginalPrice = 8
            case 0.7..<1.0:
                optionsOffsetFromOriginalPrice = 4
            default:
                optionsOffsetFromOriginalPrice = 2
        }
        return optionsOffsetFromOriginalPrice
    }
    
    func textColor() -> UIColor {
        var color: UIColor
        switch self.score {
        case 0..<0.4:
            color = UIColor(red: 0.75, green: 0.22, blue: 0.16, alpha: 1.0)
        case 0.4..<0.7:
            color = UIColor(red: 0.9, green: 0.49, blue: 0.13, alpha: 1.0)
        case 0.7..<1.0:
            color = UIColor(red: 0.55, green: 0.27, blue: 0.67, alpha: 1.0)
        default:
            color = UIColor(red: 0.16, green: 0.5, blue: 0.72, alpha: 1.0)
        }
        return color
    }
}