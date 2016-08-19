//
//  GameHomePageViewModel.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli Backup on 8/16/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import CoreData

class GameHomePageViewModel: NSObject {
    
    var productsCollection: [NSManagedObject]
    var errorMessage: String
    var productsLoading: Bool

    override init() {
        
        productsCollection = []
        errorMessage = ""
        productsLoading = true
        super.init()
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
            productsCollection = records
        case let .Failure(error):
            errorMessage = error.localizedDescription
        }
    }
}