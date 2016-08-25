//
//  ViewControllerAppearance.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/22/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {    
    func setupAppearance() {
        self.navigationController?.navigationBar.barTintColor = Appearance.defaultAppColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = .whiteColor()
    }
}