//
//  JKWayfairPriceGameTests.swift
//  JKWayfairPriceGameTests
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import XCTest
@testable import JKWayfairPriceGame

class JKWayfairPriceGameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let gamePage = GameViewModel(products: [])
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
