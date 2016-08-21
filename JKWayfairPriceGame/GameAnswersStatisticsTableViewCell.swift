//
//  GameAnswersStatisticsTableViewCell.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

enum StatsLabel: Int {
    case Correct = 1
    case Incorrect = 0
    
    func labelColor() -> UIColor {
        switch self {
        case .Correct:
            return UIColor(red: 0.55, green: 0.27, blue: 0.67, alpha: 1.0)
        case .Incorrect:
            return UIColor(red: 0.75, green: 0.22, blue: 0.16, alpha: 1.0)
        }
    }
}

class GameAnswersStatisticsTableViewCell: UITableViewCell {

    let answersStatsLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.answersStatsLabel = UILabel()
        self.answersStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.answersStatsLabel.numberOfLines = 0        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.answersStatsLabel)
        
        let views = ["answersStatsLabel": answersStatsLabel]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[answersStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[answersStatsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWithAnswer(answer: QuizAnswer) {
        answersStatsLabel.text = "\(answer.title)\n\nGiven Answer: \(answer.selectedOption)\n\nExpected Answer: \(answer.correctOption)"
        answersStatsLabel.textColor = StatsLabel(rawValue: Int(answer.isCorrect))?.labelColor()
    }
}