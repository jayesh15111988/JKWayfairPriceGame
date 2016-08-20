//
//  OptionsView.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit
import BlocksKit

class OptionsView: UIView {
    
    var options: [QuizOption]
    var buttons: [UIButton]
    var selectionClosure: ((Int) -> Void)?
    
    init() {
        
        self.options = []
        self.buttons = []
        
        super.init(frame: CGRect.zero)
        
        for index in 0..<4 {
            let button = UIButton(type: .System)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderWidth = 1.0
            button.titleLabel?.textAlignment = .Center
            button.layer.borderColor = UIColor.lightGrayColor().CGColor
            button.bk_whenTapped({
              self.view(false)
              self.selectionClosure?(index)
            })
            self.addSubview(button)
            buttons.append(button)
        }
        
        let views = ["topLeft": buttons[0], "topRight": buttons[1], "bottomLeft": buttons[2], "bottomRight": buttons[3]];
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[topLeft]-[topRight(==topLeft)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[bottomLeft]-[bottomRight(==bottomLeft)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[topLeft]-[bottomLeft(==topLeft)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[topRight]-[bottomRight(==topRight)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func updateWithOptions(options: [QuizOption]) {
        view(true)
        var index = 0
        for option in options {
            buttons[index].setTitle(option.name, forState: .Normal)
            index = index + 1
        }
    }
    
    func view(enableInteraction:Bool) {
        if enableInteraction == true {
            self.alpha = 1.0
        } else {
            self.alpha = 0.5
        }
        self.userInteractionEnabled = enableInteraction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
