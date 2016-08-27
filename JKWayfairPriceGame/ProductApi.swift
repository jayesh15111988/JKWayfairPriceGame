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
    case JSON = "json"
    case HTML = "html"
}

enum ModelType: String {
    case Product
    case ProductCategory
}

enum ProductStorageIndicatorKey: String {
    case ProductStored
}

enum Result {
    case SuccessCoreDataModels([NSManagedObject])
    case SuccessMantleModels([MTLModel])
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
                if let data = data as? [String: AnyObject] {
                    
                    if let collection = data["product_collection"] as? [[String: AnyObject]] {
                    
                        do {
                            if let productsCollection = try MTLJSONAdapter.modelsOfClass(Product.self, fromJSONArray: collection) as? [Product] {
                                
                                for product in productsCollection {
                                    product.categoryIdentifier = categoryIdentifier
                                }
                                
                                ProductDatabaseStorer().objectsStoredToDatabaseWithProducts(productsCollection, categoryIdentifier: categoryIdentifier)
                                completion(.SuccessMantleModels(productsCollection))
                            }
                        } catch let error as NSError {
                            completion(.Failure(error))
                        }
                    } else if let collection = data["subcategories"] as? [[String: AnyObject]] {
                        do {
                            if let productCategoriesCollection = try MTLJSONAdapter.modelsOfClass(ProductCategory.self, fromJSONArray: collection) as? [ProductCategory] {
                                completion(.SuccessMantleModels(productCategoriesCollection))
                            }
                        } catch let error as NSError {
                            completion(.Failure(error))
                        }
                    }
                } else {
                    completion(.Failure(NSError(domain: "WFProducts", code: 100, userInfo: [NSLocalizedDescriptionKey: "Could not parse incoming json to expected format"])))
                }
            case .Failure(let error):
                completion(.Failure(error))
            }
        }
    }
}