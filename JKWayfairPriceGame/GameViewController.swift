//
//  GameViewController.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    let gameViewModel: GameViewModel
    let skipQuestionButton: UIButton
    //let finishQuizButton: UIButton
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        self.skipQuestionButton = UIButton()
        self.skipQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        self.skipQuestionButton.setTitleColor(.blackColor(), forState: .Normal)
        self.skipQuestionButton.setTitle("Skip", forState: .Normal)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor();
        self.title = "Price Guessing Game"
        
        self.view.addSubview(self.skipQuestionButton)
        
        let views = ["skipQuestionButton": skipQuestionButton]
        
        
        RACObserve(self.gameViewModel, keyPath: "questionObject").ignore(nil).subscribeNext { (questionObject) in
            self.makeGravityTransition({ 
                self.title = self.gameViewModel.questionObject?.title
            })
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}