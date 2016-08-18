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
    func storeToDatabaseWith(models: [StoreModel])
}

class ProductDatabaseStorer: ModelStorerProtocol {
    typealias StoreModel = Product
    func storeToDatabaseWith(products: [StoreModel]) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        for product in products {
            do {
                let newProduct = try MTLManagedObjectAdapter.managedObjectFromModel(product, insertingIntoContext: managedContext)
                print(newProduct)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as  NSError {
            print("Error in saving the managed context \(error.localizedDescription)")
        }
        
        
        let fetchRequest   = NSFetchRequest(entityName: "Product")
        
        do
        {
            let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        
            if let results = fetchedResult {
                print("count \(results.count)")
                for resul in results {
                    //print(resul.valueForKey("name"))
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    
    func documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    }
}