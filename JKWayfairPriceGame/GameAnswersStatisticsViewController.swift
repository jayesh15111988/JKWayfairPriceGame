//
//  GameScoresStatisticsViewController.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class GameAnswersStatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let answers: [QuizAnswer]
    let score: Int
    let tableView: UITableView
    
    init(answers: [QuizAnswer], score: Int) {
        self.answers = answers
        self.score = score
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UITableView()
        tableView.separatorStyle = .SingleLine
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64
        tableView.registerClass(GameAnswersStatisticsTableViewCell.self, forCellReuseIdentifier: String(GameAnswersStatisticsTableViewCell.self))
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Score: \(self.score)"
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .whiteColor()
        self.view.addSubview(self.tableView)        
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "tableView": tableView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    // MARK: tableView Datasource and Delegate methods.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(String(GameAnswersStatisticsTableViewCell.self), forIndexPath: indexPath) as? GameAnswersStatisticsTableViewCell {
            cell.setupWithAnswer(answers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
