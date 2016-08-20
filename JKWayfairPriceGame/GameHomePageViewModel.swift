//
//  GameHomePageViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import CoreData
import ReactiveCocoa
import MTLManagedObjectAdapter

class GameHomePageViewModel: NSObject {
    
    dynamic var productsCollection: [Product]
    dynamic var errorMessage: String
    dynamic var productsLoading: Bool
    var startGameActionCommand: RACCommand?
    dynamic var gameViewModel: GameViewModel?

    override init() {
        self.productsCollection = []
        self.errorMessage = ""
        self.productsLoading = true
        super.init()
        
        startGameActionCommand = RACCommand(signalBlock: {[unowned self] (val) -> RACSignal! in
            self.gameViewModel = GameViewModel(products: self.productsCollection)
            return RACSignal.empty()
        })
        if let productsStored = NSUserDefaults.standardUserDefaults().objectForKey(ProductStorageIndicatorKey.ProductStored.rawValue) as? Bool where productsStored == true {
            let result = ProductDatabaseStorer().productsFromDatabase()
            validateProducts(result)
        } else {
            loadProdcutsFromAPI()
        }
    }
    
    func loadProdcutsFromAPI() {
        ProductApi.sharedInstance.productsWith("419247", format: .json, completion: { result in
            self.validateProducts(result)
        })
    }
    
    func validateProducts(result: Result) {
        self.productsLoading = false
        switch result {
        case let .Success(records):
            
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
            productsCollection = tempProducts
        case let .Failure(error):
            errorMessage = error.localizedDescription
        }
    }
}