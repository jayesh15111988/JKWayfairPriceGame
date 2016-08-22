//
//  GameHomePage.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import BlocksKit
import Foundation
import UIKit

class GameHomePageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let viewModel: GameHomePageViewModel
    let categoryInputTextField: UITextField
    var selectedCategoryIdentifier: String
    let instructionsViewController: GameInstructionsViewController
    
    init(viewModel: GameHomePageViewModel) {
        self.viewModel = viewModel
        self.selectedCategoryIdentifier = ""
        self.categoryInputTextField = UITextField()
        self.categoryInputTextField.translatesAutoresizingMaskIntoConstraints = false
        self.categoryInputTextField.borderStyle = .Line
        self.categoryInputTextField.textAlignment = .Center
        self.categoryInputTextField.font = UIFont.systemFontOfSize(16)
        self.categoryInputTextField.placeholder = "Please Choose Product Category"
        self.instructionsViewController = GameInstructionsViewController(viewModel: GameInstructionsViewModel())
        super.init(nibName: nil, bundle: nil)
        self.instructionsViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismiss))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Price Guessing Game"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let instructionsButton = UIButton(frame: CGRectMake(0, 0, 34, 34))
        instructionsButton.setImage(UIImage(named: "instructions"), forState: .Normal)
        instructionsButton.bk_whenTapped { [unowned self] in
            self.showInstructionsView()
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: instructionsButton)
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .redColor();
        
        let basicInstructionsLabel = UILabel()
        basicInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        basicInstructionsLabel.numberOfLines = 0
        basicInstructionsLabel.text = "Please select the category of your choice from the picker below and press Begin Game button to start the quiz"
        contentView.addSubview(basicInstructionsLabel)
        
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.width, 44))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelSelection)), UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(finishSelection))]
    
        categoryInputTextField.inputView = pickerView
        categoryInputTextField.inputAccessoryView = toolbar
        contentView.addSubview(categoryInputTextField)
        
        let beginGameButton = UIButton(type: .System)
        beginGameButton.translatesAutoresizingMaskIntoConstraints = false
        beginGameButton.setTitle("Begin Game", forState: .Normal)
        beginGameButton.setTitleColor(.blackColor(), forState: .Normal)
        beginGameButton.rac_command = self.viewModel.startGameActionCommand
        contentView.addSubview(beginGameButton)
        
        let beginGameWithDefaultsButton = UIButton(type: .System)
        beginGameWithDefaultsButton.translatesAutoresizingMaskIntoConstraints = false
        beginGameWithDefaultsButton.setTitle("Begin Game Default Category", forState: .Normal)
        beginGameWithDefaultsButton.setTitleColor(.blackColor(), forState: .Normal)
        beginGameWithDefaultsButton.rac_command = self.viewModel.startGameWithDefaultActionCommand
        contentView.addSubview(beginGameWithDefaultsButton)
        
        let resetCategoriesButton = UIButton(type: .System)
        resetCategoriesButton.translatesAutoresizingMaskIntoConstraints = false
        resetCategoriesButton.setTitle("Reset Categories", forState: .Normal)
        resetCategoriesButton.setTitleColor(.blackColor(), forState: .Normal)
        resetCategoriesButton.rac_command = self.viewModel.resetCategoriesActionCommand
        contentView.addSubview(resetCategoriesButton)
        
        self.view.addSubview(activityIndicatorView)
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["topLayoutGuide": topLayoutGuide, "beginGameButton": beginGameButton, "contentView": contentView, "scrollView": scrollView, "basicInstructionsLabel": basicInstructionsLabel, "categoryInputTextField": categoryInputTextField, "beginGameWithDefaultsButton": beginGameWithDefaultsButton, "resetCategoriesButton": resetCategoriesButton]
        let metrics = ["inputFieldHeight": 34, "bottomViewPadding": 40, "defaultViewPadding": 20]
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[basicInstructionsLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[categoryInputTextField]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[beginGameButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[beginGameWithDefaultsButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[resetCategoriesButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-defaultViewPadding-[basicInstructionsLabel(>=0)]-defaultViewPadding-[categoryInputTextField(inputFieldHeight)]-[beginGameButton(inputFieldHeight)]-[beginGameWithDefaultsButton(inputFieldHeight)]-[resetCategoriesButton(inputFieldHeight)]-bottomViewPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        RACObserve(viewModel, keyPath: "productsLoading").subscribeNext { (loading) in
            if let loading = loading as? Bool {
                if (loading == true) {
                    activityIndicatorView.startAnimating()
                } else {
                    activityIndicatorView.stopAnimating()
                }
            }
        }
        
        RACObserve(viewModel, keyPath: "defaultGameModeStatus").ignore(nil).subscribeNext { (defaultGameModeStatus) in
            if let defaultGameModeStatus = defaultGameModeStatus as? Bool {
                beginGameButton.userInteractionEnabled = !defaultGameModeStatus
                beginGameButton.alpha = defaultGameModeStatus == true ? 0.5 : 1.0
            }
        }
        
        RACObserve(viewModel, keyPath: "errorMessage").ignore("").ignore(nil).subscribeNext { (errorMessage) in
            if let errorMessage = errorMessage as? String {
                let alertController = UIAlertController(title: "Product Quiz", message: errorMessage, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
        }
        
        RACObserve(viewModel, keyPath: "gameViewModel").ignore(nil).subscribeNext { (gameViewModel) in
            if let gameViewModel = gameViewModel as? GameViewModel {
                let gameViewController = GameViewController(gameViewModel: gameViewModel as GameViewModel)
                self.navigationController?.pushViewController(gameViewController, animated: true)
            }
        }
        
        RACObserve(viewModel, keyPath: "productCategoriesCollection").ignore(nil).subscribeNext { (productCategoriesCollection) in
            if let productCategoriesCollection = productCategoriesCollection as? [ProductCategory] {
                self.categoryInputTextField.text = productCategoriesCollection[0].categoryName
                self.selectedCategoryIdentifier = String(productCategoriesCollection[0].categoryIdentifier)
                pickerView.reloadAllComponents()
                pickerView.selectRow(0, inComponent: 0, animated: false)
                self.categoryInputTextField.becomeFirstResponder()
            }
        }
        
        self.rac_signalForSelector(#selector(viewDidAppear)).take(1).subscribeNext { [unowned self]
            (_) in
            self.showInstructionsView()
        }
    }
    
    func showInstructionsView() {
        self.presentViewController(UINavigationController(rootViewController: instructionsViewController), animated: true, completion: nil)
    }
    
    func finishSelection() {
        self.categoryInputTextField.resignFirstResponder()        
        self.viewModel.searchWithSelectedCategoryIdentifier(self.selectedCategoryIdentifier)
    }
    
    func cancelSelection() {
        self.categoryInputTextField.resignFirstResponder()
    }
    
    func dismiss() {
        self.instructionsViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: UIPickerView datasource and delegate methods
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.productCategoriesCollection.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryInputTextField.text = self.viewModel.productCategoriesCollection[row].categoryName
        self.selectedCategoryIdentifier = String(self.viewModel.productCategoriesCollection[row].categoryIdentifier)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.productCategoriesCollection[row].categoryName
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}