//
//  GameViewController.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GameViewController: UIViewController {
    let gameViewModel: GameViewModel
    let skipQuestionButton: UIButton
    let finishQuizButton: UIButton
    let viewProductOnlineButton: UIButton
    let productImageView: UIImageView
    let productNameLabel: UILabel
    let optionsView: OptionsView
    let quizParentView: UIView
    
    var dynamicAnimator: UIDynamicAnimator?
    var snapBehavior: UISnapBehavior?
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel        
        self.skipQuestionButton = UIButton()
        self.skipQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        self.skipQuestionButton.setTitleColor(.blackColor(), forState: .Normal)
        self.skipQuestionButton.rac_command = self.gameViewModel.skipQuestionActionCommand
        self.skipQuestionButton.setTitle("Skip", forState: .Normal)
        
        self.quizParentView = UIView()
        self.quizParentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.finishQuizButton = UIButton()
        self.finishQuizButton.translatesAutoresizingMaskIntoConstraints = false
        self.finishQuizButton.setTitleColor(.blackColor(), forState: .Normal)
        self.finishQuizButton.rac_command = self.gameViewModel.finisQuizActionCommand
        self.finishQuizButton.setTitle("Finish", forState: .Normal)
        
        self.viewProductOnlineButton = UIButton()
        self.viewProductOnlineButton.translatesAutoresizingMaskIntoConstraints = false
        self.viewProductOnlineButton.setTitleColor(.blackColor(), forState: .Normal)
        self.viewProductOnlineButton.rac_command = self.gameViewModel.viewProductOnlineActionCommand
        self.viewProductOnlineButton.setTitle("View Product Online", forState: .Normal)
        
        self.productImageView = UIImageView()
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.contentMode = .ScaleAspectFit
        self.productImageView.clipsToBounds = true
        
        self.productNameLabel = UILabel()
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productNameLabel.numberOfLines = 0
        self.productNameLabel.textAlignment = .Center
        
        self.optionsView = OptionsView()
        self.optionsView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        self.optionsView.selectionClosure = { (selectedIndex) in
            self.gameViewModel.selectedOptionIndex = selectedIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor();
        self.title = "Price Guessing Game"
        
        self.view.addSubview(self.quizParentView)
        
        quizParentView.addSubview(self.skipQuestionButton)
        quizParentView.addSubview(self.finishQuizButton)
        quizParentView.addSubview(self.viewProductOnlineButton)
        quizParentView.addSubview(self.productImageView)
        quizParentView.addSubview(self.optionsView)
        quizParentView.addSubview(self.productNameLabel)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "quizParentView": quizParentView, "productNameLabel": productNameLabel, "productImageView": productImageView, "viewProductOnlineButton": viewProductOnlineButton, "optionsView": optionsView, "skipQuestionButton": skipQuestionButton, "finishQuizButton": finishQuizButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[productNameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[productImageView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[optionsView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[viewProductOnlineButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[skipQuestionButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[finishQuizButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[productNameLabel(>=0)]-[productImageView(200)]-[optionsView(100)]-[viewProductOnlineButton]-[skipQuestionButton]-[finishQuizButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][quizParentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[quizParentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(self.gameViewModel, keyPath: "questionObject").ignore(nil).subscribeNext { (questionObject) in
            self.view.makeGravityTransition({
                if let questionObject = questionObject as? QuizQuestion {
                    self.productNameLabel.text = self.gameViewModel.selectedProduct?.name
                    self.productImageView.sd_setImageWithURL(self.gameViewModel.selectedProduct?.imageURL, placeholderImage: UIImage(named: "placeholder_image"))
                    self.optionsView.updateWithOptions(questionObject.options)
                    let productURLAvailable = self.gameViewModel.selectedProduct?.productURL != nil
                    self.viewProductOnlineButton.userInteractionEnabled = productURLAvailable
                    self.viewProductOnlineButton.alpha = productURLAvailable ? 1.0 : 0.5
                }
            })
        }
        
        RACObserve(self.gameViewModel, keyPath: "productWebViewerViewModel").ignore(nil).subscribeNext { (productWebViewerViewModel) in
            if let productWebViewerViewModel = productWebViewerViewModel as? ProductWebViewerViewModel {
                let webViewerViewController = ProductWebViewController(viewModel: productWebViewerViewModel)
                self.navigationController?.pushViewController(webViewerViewController, animated: true)
            }
        }
        
        RACObserve(self.gameViewModel, keyPath: "finalQuizScoreViewModel").ignore(nil).subscribeNext {
            (finalQuizScoreViewModel) in
            if let finalQuizScoreViewModel = finalQuizScoreViewModel as? FinalScoreIndicatorViewModel {
                let finalQuizScoreView = FinalScoreIndicatorView(viewModel: finalQuizScoreViewModel, frame: CGRectMake(-200, -200, self.view.frame.width - 20, self.view.frame.height/3.0))
                self.view.addSubview(finalQuizScoreView)
                self.snapBehavior = UISnapBehavior(item: finalQuizScoreView, snapToPoint: self.view.center)
                self.snapBehavior?.damping = 0.4
                self.dynamicAnimator?.addBehavior(self.snapBehavior!)
            }
        }
        
        RACObserve(self.gameViewModel, keyPath: "goBackToHomePage").ignore(false).subscribeNext {
            (goBackToHomePage) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        RACObserve(self.gameViewModel, keyPath: "viewStatistics").ignore(false).subscribeNext {
            (viewStatistics) in
            // Present User with Quiz stats
        }
        
        RACObserve(self.gameViewModel, keyPath: "enableViewInteraction").skip(1).subscribeNext { (enableViewInteractionFlag) in
            if let enableViewInteraction = enableViewInteractionFlag as? Bool {
                self.enableView(enableViewInteraction)
            }
        }
        
    }
    
    func enableView(enable: Bool) {
        var alpha: CGFloat = 0.2
        if (enable == true) {
            alpha = 1.0
        }
        UIView.animateWithDuration(0.75) {
            self.quizParentView.alpha = alpha
        }
        self.quizParentView.userInteractionEnabled = enable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}