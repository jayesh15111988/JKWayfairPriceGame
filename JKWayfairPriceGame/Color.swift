//
//  Colors.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

// Ref: http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 08) & 0xff) / 255,
            blue: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)        
    }
}