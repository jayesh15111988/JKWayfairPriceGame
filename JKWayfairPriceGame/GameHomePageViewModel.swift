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
    dynamic var productCategoriesCollection: [ProductCategory]
    dynamic var errorMessage: String
    dynamic var productsLoading: Bool
    var categoryIdentifier: String
    var startGameActionCommand: RACCommand?
    dynamic var gameViewModel: GameViewModel?

    override init() {
        self.productsCollection = []
        self.productCategoriesCollection = []
        self.errorMessage = ""
        self.productsLoading = false
        self.categoryIdentifier = "419247"
        super.init()
        
        startGameActionCommand = RACCommand(signalBlock: {[unowned self] (val) -> RACSignal! in
            let storedProductsResult = ProductDatabaseStorer().productsFromDatabaseWith(self.categoryIdentifier, entityType: ModelType.Product)
            switch storedProductsResult {
                case .SuccessMantleModels(_):
                    self.validateProducts(storedProductsResult)
                case let Result.Failure(error):
                    print("Failed to retrieve data from database with error \(error.localizedDescription)")
                default:
                    print("Unable to fetch records from database")
            }
            return RACSignal.empty()
        })
    }
    
func loadProductsFromAPIwithCategoryIdentifier(categoryIdentifier: String) {
        self.productsLoading = true
        ProductApi.sharedInstance.productsWith(categoryIdentifier, format: .json, completion: { result in
            self.validateProducts(result)
        })
    }
    
    func validateProducts(result: Result) {
        switch result {
        case let .SuccessMantleModels(models):
            if models.count > 0 {
                if let models = models as? [Product] {
                    productsCollection = models
                    self.gameViewModel = GameViewModel(products: self.productsCollection)
                } else if let models = models as? [ProductCategory] {
                    productCategoriesCollection = models
                }
            } else {
                self.loadProductsFromAPIwithCategoryIdentifier(self.categoryIdentifier)
            }
        case let .Failure(error):
            errorMessage = error.localizedDescription
        case .SuccessCoreDataModels(_):
            print("Retrieved Core data models")
        }
    }
}