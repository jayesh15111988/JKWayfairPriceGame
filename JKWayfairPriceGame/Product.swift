//
//  Product.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import CoreData
import Foundation
import MTLManagedObjectAdapter
import Mantle

enum Availability: String {
    case Available
    case Unavailable
}

class Product: MTLModel, MTLJSONSerializing, MTLManagedObjectSerializing {
    var categoryIdentifier: String = ""
    var averageOverallRating: NSNumber = 0
    var availability: String = Availability.Unavailable.rawValue
    var imageURL: NSURL? = nil
    var listPrice: NSNumber = 0
    var manufacturerIdentifier: NSNumber = 0
    var manufacturerName: String = ""
    var name: String = ""
    var productURL: NSURL? = nil
    var salePrice: NSNumber = 0
    var salePriceRounded: NSNumber = 0
    var sku: String = ""
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["averageOverallRating": "average_overall_rating",
        "availability": "has_stock",
        "imageURL": "image_url",
        "listPrice": "list_price",
        "manufacturerIdentifier": "manufacturer_id",
        "manufacturerName": "manufacturer_name",
        "name": "name",
        "productURL": "product_url",
        "salePrice": "sale_price",
        "salePriceRounded": "sale_price",
        "sku": "sku"]
    }
    
    static func imageURLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    static func productURLJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    static func availabilityJSONTransformer() -> NSValueTransformer {
        return NSValueTransformer.mtl_valueMappingTransformerWithDictionary([true: "Available", false: "Unavailable"])
    }
    
    static func salePriceRoundedJSONTransformer() -> NSValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { (originalSalePrice, success, error) -> AnyObject! in
            if let originalSalePrice = originalSalePrice as? NSNumber {
                return round(originalSalePrice.doubleValue)
            }
            return 0
        })
    }
    
    // MARK: MTLManagedObjectSerializing
    static func managedObjectEntityName() -> String! {
        return "Product"
    }
    
    static func managedObjectKeysByPropertyKey() -> [NSObject : AnyObject]! {
        return ["categoryIdentifier": "categoryIdentifier",
                "availability": "availability",
                "averageOverallRating": "averageOverallRating",
                "imageURL": "imageURL",
                "listPrice": "listPrice",
                "salePriceRounded": "salePriceRounded",
                "manufacturerIdentifier": "manufacturerIdentifier",
                "manufacturerName": "manufacturerName",
                "name": "name",
                "productURL": "productURL",
                "salePrice": "salePrice",
                "sku": "sku"]
    }
    
    static func imageURLEntityAttributeTransform() -> NSValueTransformer {        
        return NSValueTransformer(forName: MTLURLValueTransformerName)!.mtl_invertedTransformer()
    }
    
    static func productURLEntityAttributeTransform() -> NSValueTransformer {
        return NSValueTransformer(forName: MTLURLValueTransformerName)!.mtl_invertedTransformer()
    }
    
    static func propertyKeysForManagedObjectUniquing() -> Set<NSObject>! {
        return NSSet(object: "sku") as Set<NSObject>
    }
}
