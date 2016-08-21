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
import Mantle
import MTLManagedObjectAdapter

class GameHomePageViewModel: NSObject {
    
    let defaultCategoryIdentifier = "419247"
    dynamic var productsCollection: [Product]
    dynamic var productCategoriesCollection: [ProductCategory]
    dynamic var errorMessage: String
    dynamic var productsLoading: Bool
    var categoryIdentifier: String
    var startGameActionCommand: RACCommand?
    var startGameWithDefaultActionCommand: RACCommand?
    var resetCategoriesActionCommand: RACCommand?
    dynamic var gameViewModel: GameViewModel?

    override init() {
        self.productsCollection = []
        self.productCategoriesCollection = []
        self.errorMessage = ""
        self.productsLoading = false
        self.categoryIdentifier = defaultCategoryIdentifier
        
        super.init()
        
        self.loadBaseCategories()
        
        startGameActionCommand = RACCommand(signalBlock: { [unowned self] (_) -> RACSignal! in
            self.searchWithSelectedCategoryIdentifier(self.categoryIdentifier)
            return RACSignal.empty()
        })
        
        startGameWithDefaultActionCommand = RACCommand(signalBlock: { [unowned self] (_) -> RACSignal! in
            self.searchWithSelectedCategoryIdentifier(self.defaultCategoryIdentifier)
            return RACSignal.empty()
        })
        
        resetCategoriesActionCommand = RACCommand(signalBlock: { [unowned self] (_) -> RACSignal! in
            self.productsCollection = []
            self.loadBaseCategories()
            return RACSignal.empty()
            })
    }
    
    func loadBaseCategories() {
        if let baseProductCategories = JSONReader().readJSONFromFileWith("ProductBaseCategories") as? [String: AnyObject], let categoriesCollection = baseProductCategories["subcategories"] as? [[String: AnyObject]] {
            do {
                if let productCategoriesCollection = try MTLJSONAdapter.modelsOfClass(ProductCategory.self, fromJSONArray: categoriesCollection) as? [ProductCategory] {
                    self.productCategoriesCollection = productCategoriesCollection
                }
            } catch let error as NSError {
                print("Failed to load base product categories. Failed with error \(error.localizedDescription)")
            }
        }
    }
    
    func searchWithSelectedCategoryIdentifier(categoryIdentifier: String) {
        self.categoryIdentifier = categoryIdentifier
        let storedProductsResult = ProductDatabaseStorer().productsFromDatabaseWith(categoryIdentifier, entityType: ModelType.Product)
        switch storedProductsResult {
            case .SuccessMantleModels(_):
                self.validateProducts(storedProductsResult)
            case let Result.Failure(error):
                print("Failed to retrieve data from database with error \(error.localizedDescription)")
            default:
                print("Unable to fetch records from database")
        }
    }
    
    func loadProductsFromAPIwithCategoryIdentifier(categoryIdentifier: String) {
        self.productsLoading = true
        ProductApi.sharedInstance.productsWith(categoryIdentifier, format: .json, completion: { result in
            self.validateProducts(result)
        })
    }
    
    func validateProducts(result: Result) {
        self.productsLoading = false
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