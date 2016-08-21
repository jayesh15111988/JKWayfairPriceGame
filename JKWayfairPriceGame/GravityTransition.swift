//
//  GravityTransition.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func makeGravityTransition(change: () -> Void) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let currentViewScreenshot = UIGraphicsGetImageFromCurrentImageContext()
        let frontConverImageView = UIImageView(image: currentViewScreenshot)
        frontConverImageView.frame = self.bounds
        self.addSubview(frontConverImageView)
        change()
        frontConverImageView.addGravity()
    }
    
    func addGravity() {
        if let superView = self.superview {
        let dynamicAnimator = UIDynamicAnimator(referenceView: superview!)
        let gravityBehaviour = UIGravityBehavior(items: [self])
        let dynamicItemBehaviour = UIDynamicItemBehavior(items: [self])
        dynamicItemBehaviour.allowsRotation = true
        gravityBehaviour.gravityDirection = CGVectorMake (-2, 5)
        gravityBehaviour.action = {
            if (self.frame.intersects(superView.frame) == false) {
                    self.removeFromSuperview()
                    dynamicAnimator.removeAllBehaviors()
            }
        }
        
        dynamicAnimator.removeAllBehaviors()
        dynamicItemBehaviour.addAngularVelocity(CGFloat(5), forItem: self)
        dynamicAnimator.addBehavior(dynamicItemBehaviour)
        dynamicAnimator.addBehavior(gravityBehaviour)
        }
    }
    
}