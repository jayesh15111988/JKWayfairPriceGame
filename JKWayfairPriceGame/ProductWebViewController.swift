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
    
    init (viewModel: ProductWebViewerViewModel) {
        self.viewModel = viewModel
        self.webView = UIWebView()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.scalesPageToFit = true
        super.init(nibName: nil, bundle: nil)
        self.webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.view.addSubview(self.webView)
        self.webView.loadRequest(NSURLRequest(URL: self.viewModel.webURL))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}