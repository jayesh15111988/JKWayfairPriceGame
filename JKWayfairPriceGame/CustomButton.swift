//
//  CustomButton.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            if newValue {
                alpha = 0.4
            }
            else {
                alpha = 1.0
            }
            super.highlighted = newValue
        }
    }

}