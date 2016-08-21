//
//  GameInstructionsViewController.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/21/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class GameInstructionsViewController: UIViewController {
    
    let viewModel: GameInstructionsViewModel
    
    init(viewModel: GameInstructionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "Instructions"
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.selectable = false
        textView.editable = false
        textView.text = viewModel.instructions
        textView.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(textView)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "textView": textView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][textView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

    }        
}