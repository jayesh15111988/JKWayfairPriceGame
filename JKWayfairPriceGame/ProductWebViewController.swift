//
//  ProductWebViewer.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ProductWebViewController: UIViewController, WKNavigationDelegate {
    
    let viewModel: ProductWebViewerViewModel
    let webView: WKWebView
    let activityIndicatorView: UIActivityIndicatorView
    var errorMessage: String
    var loadingLabel: UILabel
    
    init (viewModel: ProductWebViewerViewModel) {
        self.viewModel = viewModel
        self.webView = WKWebView(frame: .zero)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.contentScaleFactor = 1.0
        
        self.activityIndicatorView = UIActivityIndicatorView()
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge
        self.activityIndicatorView.color = Appearance.defaultAppColor()
        
        self.errorMessage = ""
        
        self.loadingLabel = UILabel()
        self.loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.loadingLabel.numberOfLines = 0
        self.loadingLabel.font = Appearance.extraLargeFont()
        
        super.init(nibName: nil, bundle: nil)
        self.webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .whiteColor()
        self.title = self.viewModel.product.name
        self.view.addSubview(self.webView)
        self.view.addSubview(self.activityIndicatorView)
        self.view.addSubview(self.loadingLabel)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["webView": webView, "topLayoutGuide": topLayoutGuide]
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: self.loadingLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.loadingLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: -44))
        
        self.webView.loadRequest(NSURLRequest(URL: self.viewModel.product.productURL!))
        
        RACObserve(self.webView, keyPath: "estimatedProgress").subscribeNext { [unowned self] (progress) in
            if let progress = progress as? Double {
                self.loadingLabel.text = String(Int(progress * 100.0)) + "%"
            }
        }
        
        RACObserve(self.webView, keyPath: "loading").subscribeNext { [unowned self] (loading) in
            if let loading = loading as? Bool {
                if loading == true {
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.activityIndicatorView.stopAnimating()
                }
                self.loadingLabel.hidden = !loading
            }
        }
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        activityIndicatorView.stopAnimating()
        let errorMessage = error.localizedDescription
        let alertController = UIAlertController(title: self.viewModel.product.name, message: errorMessage, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}