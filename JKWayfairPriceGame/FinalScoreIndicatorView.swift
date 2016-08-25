//
//  FinalScoreIndicatorView.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class FinalScoreIndicatorView: UIView {
    
    let viewModel: FinalScoreIndicatorViewModel
    
    init(viewModel: FinalScoreIndicatorViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0xbdc3c7)
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(hex: 0x27ae60).CGColor
        
        let goBackButton = CustomButton()
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.setTitleColor(.blackColor(), forState: .Normal)
        goBackButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        goBackButton.backgroundColor = Appearance.secondaryButtonBackgroundColor()
        goBackButton.rac_command = self.viewModel.goBackButtonActionCommand
        goBackButton.titleLabel?.font = Appearance.buttonsFont()
        goBackButton.setTitle("Go Back", forState: .Normal)
        self.addSubview(goBackButton)
        
        let newGameButton = CustomButton()
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitleColor(.blackColor(), forState: .Normal)
        newGameButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        newGameButton.backgroundColor = Appearance.secondaryButtonBackgroundColor()
        newGameButton.titleLabel?.font = Appearance.buttonsFont()
        newGameButton.rac_command = self.viewModel.newGameButtonActionCommand
        newGameButton.setTitle("New Game", forState: .Normal)
        self.addSubview(newGameButton)
        
        let viewStatisticsButton = CustomButton()
        viewStatisticsButton.translatesAutoresizingMaskIntoConstraints = false
        viewStatisticsButton.setTitleColor(.blackColor(), forState: .Normal)
        viewStatisticsButton.rac_command = self.viewModel.viewStatisticsButtonActionCommand
        viewStatisticsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        viewStatisticsButton.setTitle("Statistics", forState: .Normal)
        viewStatisticsButton.titleLabel?.font = Appearance.buttonsFont()
        viewStatisticsButton.backgroundColor = Appearance.secondaryButtonBackgroundColor()
        let answeredAtleastOneQuestion = self.viewModel.gameViewModel.answersCollection.count > 0
        viewStatisticsButton.userInteractionEnabled = answeredAtleastOneQuestion
        viewStatisticsButton.alpha = answeredAtleastOneQuestion == true ? 1.0 : 0.5
        self.addSubview(viewStatisticsButton)
        
        let gameStatsLabel = UILabel()
        gameStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        gameStatsLabel.numberOfLines = 0
        gameStatsLabel.textAlignment = .Center
        gameStatsLabel.font = Appearance.defaultFont()
        gameStatsLabel.text = self.viewModel.totalStats
        gameStatsLabel.textColor = self.viewModel.finalScoreLabelTextColor
        self.addSubview(gameStatsLabel)
        
        let views = ["gameStatsLabel": gameStatsLabel, "goBackButton": goBackButton, "newGameButton": newGameButton, "viewStatisticsButton": viewStatisticsButton]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[gameStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[goBackButton]-[newGameButton(==goBackButton)]-[viewStatisticsButton(==newGameButton)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[gameStatsLabel]-[goBackButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[gameStatsLabel]-[newGameButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[gameStatsLabel]-[viewStatisticsButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(self.viewModel, keyPath: "finalScoreScreenOption").skip(1).subscribeNext {
            [unowned self] selectedOption in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}