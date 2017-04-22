//
//  Category.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/20/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Mantle

class ProductCategory: MTLModel, MTLJSONSerializing {
    var categoryName: String = ""
    var imageURL: NSURL?
    var categoryURL: NSURL?
    var categoryIdentifier: NSNumber = 0
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["categoryName": "display_name",
                "imageURL": "image_info.image_url",
                "categoryURL": "category_link",
                "categoryIdentifier": "category_id"]
    }
    
    static func imageURLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    static func categoryURLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
}
