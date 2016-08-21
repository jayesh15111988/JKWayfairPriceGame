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
        self.backgroundColor = .lightGrayColor()
        
        let goBackButton = UIButton()
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.setTitleColor(.blackColor(), forState: .Normal)
        goBackButton.rac_command = self.viewModel.goBackButtonActionCommand
        goBackButton.setTitle("Go Back", forState: .Normal)
        self.addSubview(goBackButton)
        
        let newGameButton = UIButton()
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitleColor(.blackColor(), forState: .Normal)
        newGameButton.rac_command = self.viewModel.newGameButtonActionCommand
        newGameButton.setTitle("New Game", forState: .Normal)
        self.addSubview(newGameButton)
        
        let viewStatisticsButton = UIButton()
        viewStatisticsButton.translatesAutoresizingMaskIntoConstraints = false
        viewStatisticsButton.setTitleColor(.blackColor(), forState: .Normal)
        viewStatisticsButton.rac_command = self.viewModel.viewStatisticsButtonActionCommand
        viewStatisticsButton.setTitle("Statistics", forState: .Normal)
        self.addSubview(viewStatisticsButton)
        
        let gameStatsLabel = UILabel()
        gameStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        gameStatsLabel.numberOfLines = 0
        gameStatsLabel.textAlignment = .Center
        gameStatsLabel.text = self.viewModel.totalStats
        self.addSubview(gameStatsLabel)
        
        let views = ["gameStatsLabel": gameStatsLabel, "goBackButton": goBackButton, "newGameButton": newGameButton, "viewStatisticsButton": viewStatisticsButton]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[gameStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[goBackButton]-[newGameButton(==goBackButton)]-[viewStatisticsButton(==newGameButton)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[gameStatsLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[goBackButton(44)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[newGameButton(44)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[viewStatisticsButton(44)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        RACObserve(self.viewModel, keyPath: "finalScoreScreenOption").skip(1).subscribeNext {
            (selectedOption) in             
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}