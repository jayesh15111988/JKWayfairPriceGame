//
//  ColorSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/12/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class ColorSpec: QuickSpec {
    
    override func spec() {
        describe("Verifying the behavior of utility converting hex string into UIColor object") {
            it("The color utility should take hex string as an input and convert it to appropriate color value", closure: { 
                let brownColor = UIColor(hex: 0x433221)
                let blueColor = UIColor(hex: 0x554291)
                let maroonColor = UIColor(hex: 0x763211)
                
                let brownColorRGBValues = self.individualRGBValues(with: brownColor)
                let blueColorRGBValues = self.individualRGBValues(with: blueColor)
                let maroonColorRGBValues = self.individualRGBValues(with: maroonColor)
                
                expect(brownColorRGBValues).toNot(beNil())
                expect(blueColorRGBValues).toNot(beNil())
                expect(maroonColorRGBValues).toNot(beNil())
                
                if let brownColorRGBValues = brownColorRGBValues {
                    expect(brownColorRGBValues[0]).to(equal(67))
                    expect(brownColorRGBValues[1]).to(equal(50))
                    expect(brownColorRGBValues[2]).to(equal(33))
                }
                
                if let blueColorRGBValues = blueColorRGBValues {
                    expect(blueColorRGBValues[0]).to(equal(85))
                    expect(blueColorRGBValues[1]).to(equal(66))
                    expect(blueColorRGBValues[2]).to(equal(145))
                }
                
                if let maroonColorRGBValues = maroonColorRGBValues {
                    expect(maroonColorRGBValues[0]).to(equal(118))
                    expect(maroonColorRGBValues[1]).to(equal(50))
                    expect(maroonColorRGBValues[2]).to(equal(17))
                }
                
            })
        }
    }
    
    func individualRGBValues(with color: UIColor) -> [Int]? {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha : CGFloat = 0
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let iRed = Int(red * 255.0)
            let iGreen = Int(green * 255.0)
            let iBlue = Int(blue * 255.0)
            return [iRed, iGreen, iBlue]
        } else {
            return nil
        }
    }
}
