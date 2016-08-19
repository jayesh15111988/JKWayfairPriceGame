//
//  GameHomePage.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import BlocksKit
import Foundation
import UIKit

class GameHomePageViewController: UIViewController {
    
    let viewModel: GameHomePageViewModel
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehaviour: UIGravityBehavior!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    
    init(viewModel: GameHomePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        self.view.backgroundColor = UIColor.whiteColor()
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .redColor();
        self.view.addSubview(activityIndicatorView)
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        let gameStartButton = UIButton(type: .System)
        gameStartButton.translatesAutoresizingMaskIntoConstraints = false
        gameStartButton.setTitle("Begin Game", forState: .Normal)
        gameStartButton.setTitleColor(.blackColor(), forState: .Normal)
        self.view.addSubview(gameStartButton)
        
        let funButton = UIButton(type: .System)
        funButton.translatesAutoresizingMaskIntoConstraints = false
        funButton.setTitle("Make Fun", forState: .Normal)
        funButton.setTitleColor(.blackColor(), forState: .Normal)
        funButton.bk_whenTapped { 
            self.makeTransition()
        }
        self.view.addSubview(funButton)
        
        let views = ["gameStartButton": gameStartButton, "funButton": funButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[gameStartButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[gameStartButton(44)]-[funButton(44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[funButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(viewModel, keyPath: "productsLoading").deliverOnMainThread().subscribeNext { (loading) in
            if let loading = loading as? Bool {
                if (loading == true) {
                    gameStartButton.alpha = 0.5
                    activityIndicatorView.startAnimating()
                } else {
                    gameStartButton.alpha = 1.0
                    activityIndicatorView.stopAnimating()
                }
                gameStartButton.enabled = !loading
            }
        }
        
        RACObserve(viewModel, keyPath: "errorMessage").ignore("").ignore(nil).subscribeNext { (errorMessage) in
            if let errorMessage = errorMessage as? String {
                let alertController = UIAlertController(title: "Product Quiz", message: errorMessage, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
        }
    }
    
    func makeTransition() {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let currentViewScreenshot = UIGraphicsGetImageFromCurrentImageContext()
        let frontConverImageView = UIImageView(image: currentViewScreenshot)
        frontConverImageView.frame = self.view.bounds
        self.view.addSubview(frontConverImageView)
        self.view.backgroundColor = .redColor()
        
        gravityBehaviour = UIGravityBehavior(items: [frontConverImageView])
        dynamicItemBehaviour = UIDynamicItemBehavior(items: [frontConverImageView])
        dynamicItemBehaviour.density = CGFloat(arc4random_uniform(5))
        gravityBehaviour.gravityDirection = CGVectorMake (CGFloat(arc4random_uniform(10)) - 8, CGFloat(arc4random_uniform(10)) - 8)
        gravityBehaviour.action = {
            if (frontConverImageView.frame.intersects(self.view.frame) == false) {
                frontConverImageView.removeFromSuperview()
                self.dynamicAnimator.removeAllBehaviors()
            }
        }                

        self.dynamicAnimator.removeAllBehaviors()
        dynamicItemBehaviour.addAngularVelocity(CGFloat(0.4), forItem: frontConverImageView)
        dynamicAnimator.addBehavior(dynamicItemBehaviour)
        dynamicAnimator.addBehavior(gravityBehaviour)
    }
}