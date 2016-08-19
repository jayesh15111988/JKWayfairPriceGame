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
    func objectsStoredToDatabaseWithProducts(models: [StoreModel]) -> Result
}

class ProductDatabaseStorer: ModelStorerProtocol {
    typealias StoreModel = Product
    func objectsStoredToDatabaseWithProducts(products: [StoreModel]) -> Result {
        
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
        return productsFromDatabase()
    }
    
    func productsFromDatabase() -> Result {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest   = NSFetchRequest(entityName: ModelType.Product.rawValue)
        do {
            let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            var records: [NSManagedObject] = []
            if let results = fetchedResult {
                records = results
            }
            return .Success(records)
        } catch let error as NSError {
            return .Failure(error)
        }
    }
}