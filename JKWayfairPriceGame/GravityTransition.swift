//
//  GravityTransition.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func makeGravityTransition(change: () -> Void) {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let currentViewScreenshot = UIGraphicsGetImageFromCurrentImageContext()
        let frontConverImageView = UIImageView(image: currentViewScreenshot)
        frontConverImageView.frame = self.view.bounds
        self.view.addSubview(frontConverImageView)
        
        change()
        
        let dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        let gravityBehaviour = UIGravityBehavior(items: [frontConverImageView])
        let dynamicItemBehaviour = UIDynamicItemBehavior(items: [frontConverImageView])
        dynamicItemBehaviour.allowsRotation = true
        gravityBehaviour.gravityDirection = CGVectorMake (-2, 5)
        gravityBehaviour.action = {
            if (frontConverImageView.frame.intersects(self.view.frame) == false) {
                frontConverImageView.removeFromSuperview()
                dynamicAnimator.removeAllBehaviors()
            }
        }
        
        dynamicAnimator.removeAllBehaviors()
        dynamicItemBehaviour.addAngularVelocity(CGFloat(5), forItem: frontConverImageView)
        dynamicAnimator.addBehavior(dynamicItemBehaviour)
        dynamicAnimator.addBehavior(gravityBehaviour)
    }
}