//
//  ProductWebViewerViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

class ProductWebViewerViewModel: NSObject {
    
    let webURL: NSURL
    
    init(webURL: NSURL) {
        self.webURL = webURL
    }
}