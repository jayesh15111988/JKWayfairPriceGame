//
//  Random.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/19/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation

func negativeRandomNumberInRange(lowerValue: Int, upperValue: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) + lowerValue
}

func positiveRandomNumberInRange(lowerValue: UInt32, upperValue: UInt32) -> UInt32 {
    return arc4random_uniform(upperValue - lowerValue) + lowerValue
}