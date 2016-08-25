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
    let quizSequenceLabel: UILabel
    let optionsView: OptionsView
    let quizParentView: UIView
    let availabilityIndicatorImage: UIImageView
    let availabilityLabel: UILabel
    
    var dynamicAnimator: UIDynamicAnimator?
    var snapBehavior: UISnapBehavior?
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel        
        self.skipQuestionButton = CustomButton()
        self.skipQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        self.skipQuestionButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.skipQuestionButton.backgroundColor = Appearance.buttonBackgroundColor()
        self.skipQuestionButton.titleLabel?.font = Appearance.buttonsFont()
        self.skipQuestionButton.rac_command = self.gameViewModel.skipQuestionActionCommand
        self.skipQuestionButton.setTitle("Skip", forState: .Normal)
        
        self.quizParentView = UIView()
        self.quizParentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.finishQuizButton = CustomButton()
        self.finishQuizButton.translatesAutoresizingMaskIntoConstraints = false
        self.finishQuizButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.finishQuizButton.backgroundColor = Appearance.buttonBackgroundColor()
        self.finishQuizButton.rac_command = self.gameViewModel.finisQuizActionCommand
        self.finishQuizButton.titleLabel?.font = Appearance.buttonsFont()
        self.finishQuizButton.setTitle("Finish", forState: .Normal)
        
        self.viewProductOnlineButton = CustomButton()
        self.viewProductOnlineButton.translatesAutoresizingMaskIntoConstraints = false
        self.viewProductOnlineButton.setTitleColor(.whiteColor(), forState: .Normal)
        self.viewProductOnlineButton.backgroundColor = Appearance.buttonBackgroundColor()
        self.viewProductOnlineButton.rac_command = self.gameViewModel.viewProductOnlineActionCommand
        self.viewProductOnlineButton.titleLabel?.font = Appearance.buttonsFont()
        self.viewProductOnlineButton.setTitle("View Product Online", forState: .Normal)
        
        self.productImageView = UIImageView()
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.contentMode = .ScaleAspectFit
        self.productImageView.clipsToBounds = true        
        self.productImageView.layer.borderWidth = 1.0
        self.productImageView.layer.borderColor = Appearance.defaultAppColor().CGColor
        
        self.availabilityIndicatorImage = UIImageView()
        self.availabilityIndicatorImage.translatesAutoresizingMaskIntoConstraints = false
        self.availabilityIndicatorImage.contentMode = .ScaleAspectFit
        self.availabilityIndicatorImage.clipsToBounds = true
        
        self.availabilityLabel = UILabel()
        self.availabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.availabilityLabel.font = Appearance.smallDefaultFont()
        self.availabilityLabel.numberOfLines = 0
        
        self.productNameLabel = UILabel()
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productNameLabel.numberOfLines = 0
        self.productNameLabel.font = Appearance.titleFont()
        self.productNameLabel.textAlignment = .Center
        
        self.quizSequenceLabel = UILabel()
        self.quizSequenceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.quizSequenceLabel.numberOfLines = 0
        self.quizSequenceLabel.font = Appearance.defaultFont()
        self.quizSequenceLabel.textAlignment = .Center
        
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
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.addSubview(quizParentView)
        
        let spacer1 = UIView()
        spacer1.translatesAutoresizingMaskIntoConstraints = false
        quizParentView.addSubview(spacer1)
        
        let spacer2 = UIView()
        spacer2.translatesAutoresizingMaskIntoConstraints = false
        quizParentView.addSubview(spacer2)
        
        quizParentView.addSubview(self.skipQuestionButton)
        quizParentView.addSubview(self.finishQuizButton)
        quizParentView.addSubview(self.viewProductOnlineButton)
        quizParentView.addSubview(self.productImageView)
        quizParentView.addSubview(self.optionsView)
        quizParentView.addSubview(self.productNameLabel)
        quizParentView.addSubview(self.availabilityIndicatorImage)
        quizParentView.addSubview(self.quizSequenceLabel)
        quizParentView.addSubview(self.availabilityLabel)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "scrollView": scrollView, "quizParentView": quizParentView, "productNameLabel": productNameLabel, "quizSequenceLabel": quizSequenceLabel, "productImageView": productImageView, "availabilityIndicatorImage": availabilityIndicatorImage, "availabilityLabel": availabilityLabel, "viewProductOnlineButton": viewProductOnlineButton, "optionsView": optionsView, "skipQuestionButton": skipQuestionButton, "finishQuizButton": finishQuizButton, "spacer1": spacer1, "spacer2": spacer2]
        let metrics = ["horizontalImagePadding": 20, "availabilityIndicatorIconDimension": 24]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Left, relatedBy: .Equal, toItem: quizParentView, attribute: .Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Right, relatedBy: .Equal, toItem: quizParentView, attribute: .Right, multiplier: 1.0, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[quizParentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[quizParentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[productNameLabel(<=400)]-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[quizSequenceLabel(>=0)]-[productImageView(<=400)]-[availabilityIndicatorImage(availabilityIndicatorIconDimension)]-horizontalImagePadding-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[optionsView(<=400)]-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[viewProductOnlineButton]-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[skipQuestionButton]-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[spacer1(==20@999)]-[finishQuizButton]-[spacer2(==spacer1@999)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[productNameLabel(>=0)]-[productImageView(200)]-[optionsView(100)]-[viewProductOnlineButton]-[skipQuestionButton]-[finishQuizButton]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: availabilityIndicatorImage, attribute: .Top, relatedBy: .Equal, toItem: productImageView, attribute: .Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: availabilityIndicatorImage, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 24))
        self.view.addConstraint(NSLayoutConstraint(item: quizSequenceLabel, attribute: .Top, relatedBy: .Equal, toItem: productImageView, attribute: .Top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: quizSequenceLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 24))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[availabilityIndicatorImage][availabilityLabel(availabilityIndicatorIconDimension)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[productImageView]-[availabilityLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        
        RACObserve(self.gameViewModel, keyPath: "questionObject").ignore(nil).subscribeNext { [unowned self] (questionObject) in
            self.view.makeGravityTransition({
                if let questionObject = questionObject as? QuizQuestion, selectedProduct = self.gameViewModel.selectedProduct {
                    self.productNameLabel.text = selectedProduct.name
                    self.productImageView.sd_setImageWithURL(selectedProduct.imageURL, placeholderImage: UIImage(named: "placeholder_image"))
                    self.optionsView.updateWithOptions(questionObject.options)
                    let productURLAvailable = selectedProduct.productURL != nil
                    self.viewProductOnlineButton.userInteractionEnabled = productURLAvailable
                    self.viewProductOnlineButton.alpha = productURLAvailable ? 1.0 : 0.5
                    self.availabilityIndicatorImage.image = UIImage(named: selectedProduct.availability)
                    self.quizSequenceLabel.text = String(self.gameViewModel.questionIndex + 1)
                    self.availabilityLabel.text = selectedProduct.availability
                }
            })
        }
        
        RACObserve(self.gameViewModel, keyPath: "productWebViewerViewModel").ignore(nil).subscribeNext { [unowned self] (productWebViewerViewModel) in
            if let productWebViewerViewModel = productWebViewerViewModel as? ProductWebViewerViewModel {
                let webViewerViewController = ProductWebViewController(viewModel: productWebViewerViewModel)
                self.navigationController?.pushViewController(webViewerViewController, animated: true)
            }
        }
        
        RACObserve(self.gameViewModel, keyPath: "finalQuizScoreViewModel").ignore(nil).subscribeNext {
            [unowned self] (finalQuizScoreViewModel) in
            if let finalQuizScoreViewModel = finalQuizScoreViewModel as? FinalScoreIndicatorViewModel {
                let viewWidth = self.view.frame.width > 300 ? 300 : self.view.frame.width
                let finalQuizScoreView = FinalScoreIndicatorView(viewModel: finalQuizScoreViewModel, frame: CGRectMake(-200, -200, viewWidth, 200))
                self.view.addSubview(finalQuizScoreView)
                self.snapBehavior = UISnapBehavior(item: finalQuizScoreView, snapToPoint: CGPoint(x: self.view.center.x, y: self.view.center.y - 100))
                self.snapBehavior?.damping = 0.4
                self.dynamicAnimator?.addBehavior(self.snapBehavior!)
            }
        }
        
        RACObserve(self.gameViewModel, keyPath: "goBackToHomePage").ignore(false).subscribeNext {
            [unowned self] (goBackToHomePage) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        RACObserve(self.gameViewModel, keyPath: "viewStatistics").ignore(false).subscribeNext {
            [unowned self] (viewStatistics) in
            let gameAnswersStatisticsViewController = GameAnswersStatisticsViewController(answers: self.gameViewModel.answersCollection)
            self.navigationController?.pushViewController(gameAnswersStatisticsViewController, animated: true)            
        }
        
        RACObserve(self.gameViewModel, keyPath: "enableViewInteraction").skip(1).subscribeNext { [unowned self] (enableViewInteractionFlag) in
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