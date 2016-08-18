//
//  ProductApi.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Alamofire
import Mantle
import Foundation

enum DataFormat: String {
    case json
    case html
}

class ProductApi {
    let baseURLString: String
    static let sharedInstance = ProductApi()
    private init() {
        baseURLString = "https://www.wayfair.com/v/category/display"
    }
    
    func productsWith(categoryIdentifier: String, format: DataFormat) {
        Alamofire.request(.GET, self.baseURLString, parameters: ["category_id": categoryIdentifier, "_format": format.rawValue], encoding: .URL, headers: nil).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .Success(let data):
                if let data = data as? [String: AnyObject], collection = data["product_collection"] as? [[String: AnyObject]] {
                        do {
                            if let productsCollection = try MTLJSONAdapter.modelsOfClass(Product.self, fromJSONArray: collection) as? [Product] {
                                let recordsStorer = ProductDatabaseStorer()
                                recordsStorer.storeToDatabaseWith(productsCollection)
                            }
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                } else {
                    print("Unable to parse incoming data")
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
}