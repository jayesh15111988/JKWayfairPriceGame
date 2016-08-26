//
//  Appearance.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class Appearance {
    
    static func defaultAppColor() -> UIColor {
        return UIColor(hex: 0x9b59b6)
    }
    
    static func correctAnswerColor() -> UIColor {
        return UIColor(hex: 0x8e44ad)
    }
    
    static func inCorrectAnswerColor() -> UIColor {
        return UIColor(hex: 0xc0392b)
    }
    
    static func lowScoreColor() -> UIColor {
        return self.inCorrectAnswerColor()
    }
    
    static func mediumScoreColor() -> UIColor {
        return UIColor(hex: 0xe67e22)
    }
    
    static func highScoreColor() -> UIColor {
        return UIColor(hex: 0x2980b9)
    }
    
    static func perfectScoreColor() -> UIColor {
        return self.correctAnswerColor()
    }
    
    static func buttonBackgroundColor() -> UIColor {
        return UIColor(hex: 0x2c3e50)
    }
    
    static func secondaryButtonBackgroundColor() -> UIColor {
        return UIColor(hex: 0x3498db)
    }
    
    static func defaultFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16)!
    }
    
    static func titleFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 16)!
    }
    
    static func buttonsFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 16)!
    }
    
    static func smallDefaultFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 11)!
    }
    
}