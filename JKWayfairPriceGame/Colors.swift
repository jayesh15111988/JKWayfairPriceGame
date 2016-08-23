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
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1.0)
        
    }
}