//
//  ProductDatabaseStore.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import BlocksKit
import MagicalRecord
import Mantle
import MTLManagedObjectAdapter
import MDMCoreData
import Foundation

protocol ModelStorerProtocol  {
    associatedtype StoreModel: MTLJSONSerializing, MTLManagedObjectSerializing
    func storeToDatabaseWith(models: [StoreModel])
}

class ProductDatabaseStorer: ModelStorerProtocol {
    typealias StoreModel = Product
    func storeToDatabaseWith(products: [StoreModel]) {
        
        let modelURL = NSBundle.mainBundle().URLForResource("JKWayfairPriceGame", withExtension: "momd")
        let storeURL = NSURL(fileURLWithPath: documentsDirectory()).URLByAppendingPathComponent("JKWayfairPriceGame.sqlite")//[NSURL fileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"model.sqlite"]];
        let persistenceController = MDMPersistenceController(storeURL: storeURL, modelURL: modelURL)
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        for product in products {
            do {
                let newProduct = try MTLManagedObjectAdapter.managedObjectFromModel(product, insertingIntoContext: managedContext)
                let name = newProduct.valueForKey("name")
                print(newProduct)
                if let newProduct = newProduct as? Product {
                    print(newProduct.name)
                }
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
                
                for resul in results {
                    print(resul.objectID)
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