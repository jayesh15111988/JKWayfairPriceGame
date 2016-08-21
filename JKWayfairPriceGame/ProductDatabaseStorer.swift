//
//  ProductDatabaseStore.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import BlocksKit
import Mantle
import MTLManagedObjectAdapter
import Foundation

protocol ModelStorerProtocol  {
    associatedtype StoreModel: MTLJSONSerializing, MTLManagedObjectSerializing
    func objectsStoredToDatabaseWithProducts(models: [StoreModel], categoryIdentifier: String) -> Result
}

class ProductDatabaseStorer: ModelStorerProtocol {
    typealias StoreModel = Product
    func objectsStoredToDatabaseWithProducts(products: [StoreModel], categoryIdentifier: String) -> Result {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        for product in products {
            do {
                try MTLManagedObjectAdapter.managedObjectFromModel(product, insertingIntoContext: managedContext)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        do {
            try managedContext.save()
            // Indicator in database to indicate the product values have been stored in the database.
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: ProductStorageIndicatorKey.ProductStored.rawValue)
        } catch let error as  NSError {
            print("Error in saving the managed context \(error.localizedDescription)")
        }
        
        return productsFromDatabaseWith(categoryIdentifier, entityType: ModelType.Product)
    }
    
    func productsFromDatabaseWith(categoryIdentifier: String, entityType: ModelType) -> Result {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest   = NSFetchRequest(entityName: entityType.rawValue)
        let predicate = NSPredicate(format: "categoryIdentifier == %@", categoryIdentifier)
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            var records: [NSManagedObject] = []
            if let results = fetchedResult {
                records = results
            }
            
            if entityType == ModelType.Product {
                var tempProducts: [Product] = []
                
                for record in records {
                    do {
                        if let productModel = try MTLManagedObjectAdapter.modelOfClass(Product.self, fromManagedObject: record) as? Product {
                            tempProducts.append(productModel)
                        }
                    } catch let error as NSError {
                        print("Failed to convert NSManagedobject to Model Object. Failed with error \(error.localizedDescription)")
                    }
                }
                return .SuccessMantleModels(tempProducts)
            }
            return .SuccessMantleModels([])
        } catch let error as NSError {
            return .Failure(error)
        }
    }
}