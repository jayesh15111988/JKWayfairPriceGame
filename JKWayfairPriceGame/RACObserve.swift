//
//  RACObserve.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/18/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import ReactiveCocoa

// Source: https://github.com/ColinEberhardt/ReactiveSwiftFlickrSearch/tree/master/ReactiveSwiftFlickrSearch/Util

// replaces the RACObserve macro
func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}