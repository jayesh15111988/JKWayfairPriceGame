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
    
    init(viewModel: GameHomePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Price Guessing Game"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .redColor();
        
        let gameInstructionsTextView = UITextView()
        gameInstructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        gameInstructionsTextView.selectable = false
        gameInstructionsTextView.editable = false
        gameInstructionsTextView.text = "adasd\nadasda\nasdasd\nasdasdas\nasdasdas\nasdasdasdas\nasdasd\n"
        contentView.addSubview(gameInstructionsTextView)
        
        let gameStartButton = UIButton(type: .System)
        gameStartButton.translatesAutoresizingMaskIntoConstraints = false
        gameStartButton.setTitle("Begin Game", forState: .Normal)
        gameStartButton.setTitleColor(.blackColor(), forState: .Normal)
        gameStartButton.rac_command = self.viewModel.startGameActionCommand
        contentView.addSubview(gameStartButton)
        
        self.view.addSubview(activityIndicatorView)
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "gameStartButton": gameStartButton, "gameInstructionsTextView": gameInstructionsTextView, "contentView": contentView, "scrollView": scrollView]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[gameStartButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[gameInstructionsTextView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[gameInstructionsTextView(150)]-[gameStartButton(44)]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(viewModel, keyPath: "productsLoading").subscribeNext { (loading) in
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
        
        RACObserve(viewModel, keyPath: "gameViewModel").ignore(nil).subscribeNext { (gameViewModel) in
            if let gameViewModel = gameViewModel as? GameViewModel {
                let gameViewController = GameViewController(gameViewModel: gameViewModel as GameViewModel)
                self.navigationController?.pushViewController(gameViewController, animated: true)
            }
        }
    }
}