//
//  GameAnswersStatisticsTableViewCell.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

enum StatsLabelType: Int {
    case Correct = 1
    case Incorrect = 0
    
    func labelColor() -> UIColor {
        switch self {
            case .Correct:
                return Appearance.correctAnswerColor()
            case .Incorrect:
                return Appearance.incorrectAnswerColor()
        }
    }
}

class GameAnswersStatisticsTableViewCell: UITableViewCell {

    let answersStatsLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.answersStatsLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.answersStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.answersStatsLabel.numberOfLines = 0
        self.answersStatsLabel.font = Appearance.defaultFont()
        self.contentView.addSubview(self.answersStatsLabel)
        
        let views = ["answersStatsLabel": answersStatsLabel]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[answersStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[answersStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func setupWithAnswer(answer: QuizAnswer) {
        answersStatsLabel.text = "\(answer.title)\n\nGiven Answer: \(answer.selectedOption)\n\nCorrect Answer: \(answer.correctOption)"
        answersStatsLabel.textColor = StatsLabelType(rawValue: Int(answer.isCorrect))?.labelColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
