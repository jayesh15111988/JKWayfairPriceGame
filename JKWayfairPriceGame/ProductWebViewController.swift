//
//  ProductWebViewer.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import UIKit

class ProductWebViewController: UIViewController, UIWebViewDelegate {
    
    let viewModel: ProductWebViewerViewModel
    let webView: UIWebView
    let activityIndicatorView: UIActivityIndicatorView
    var errorMessage: String
    
    init (viewModel: ProductWebViewerViewModel) {
        self.viewModel = viewModel
        self.webView = UIWebView()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.scalesPageToFit = true
        
        self.activityIndicatorView = UIActivityIndicatorView()
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.activityIndicatorViewStyle = .WhiteLarge
        self.activityIndicatorView.color = Appearance.defaultAppColor()
        
        self.errorMessage = ""
        
        super.init(nibName: nil, bundle: nil)
        self.webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = .whiteColor()
        self.title = self.viewModel.product.name
        self.view.addSubview(self.webView)
        self.view.addSubview(self.activityIndicatorView)
        
        let topLayoutGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["webView": webView, "topLayoutGuide": topLayoutGuide]
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide][webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        self.webView.loadRequest(NSURLRequest(URL: self.viewModel.product.productURL!))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicatorView.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        activityIndicatorView.stopAnimating()
        if let errorMessage = error?.localizedDescription {
            let alertController = UIAlertController(title: self.viewModel.product.name, message: errorMessage, preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true) {
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}