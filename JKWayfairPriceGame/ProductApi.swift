//
//  ProductApi.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Alamofire
import CoreData
import Mantle
import Foundation

enum DataFormat: String {
    case json
    case html
}

enum ModelType: String {
    case Product
}

enum ProductStorageIndicatorKey: String {
    case ProductStored
}

enum Result {
    case Success([NSManagedObject])
    case Failure(NSError)
}

class ProductApi {
    let baseURLString: String
    static let sharedInstance = ProductApi()
    private init() {
        baseURLString = "https://www.wayfair.com/v/category/display"
    }
    
    func productsWith(categoryIdentifier: String, format: DataFormat, completion: (Result) -> Void){
        Alamofire.request(.GET, self.baseURLString, parameters: ["category_id": categoryIdentifier, "_format": format.rawValue], encoding: .URL, headers: nil).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .Success(let data):
                if let data = data as? [String: AnyObject], collection = data["product_collection"] as? [[String: AnyObject]] {
                        do {
                            if let productsCollection = try MTLJSONAdapter.modelsOfClass(Product.self, fromJSONArray: collection) as? [Product] {
                                
                                for product in productsCollection {
                                    product.categoryIdentifier = categoryIdentifier
                                }
                                
                                let result = ProductDatabaseStorer().objectsStoredToDatabaseWithProducts(productsCollection)
                                completion(result)
                            }
                        } catch let error as NSError {
                            completion(.Failure(error))
                        }
                } else {
                    completion(.Failure(NSError(domain: "WFProducts", code: 100, userInfo: [NSLocalizedDescriptionKey: "Could not parse incoming json to expected format"])))
                }
            case .Failure(let error):
                completion(Result.Failure(error))
            }
        }
    }
}