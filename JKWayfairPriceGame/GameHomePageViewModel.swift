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

private let DefaultCategoriesStoredIndicator: String = "defaultCategoriesStoredIndicator"

class GameHomePageViewModel: NSObject {
    
    let defaultCategoryIdentifier = "419247"
    dynamic var productsCollection: [Product]
    dynamic var productCategoriesCollection: [ProductCategory]
    dynamic var errorMessage: String
    dynamic var productsLoading: Bool
    dynamic var defaultGameModeStatus: Bool
    dynamic var showInstructionsView: Bool
    var categoryIdentifier: String
    var startGameActionCommand: RACCommand?
    var startGameWithDefaultActionCommand: RACCommand?
    var resetCategoriesActionCommand: RACCommand?
    var gameInstructionsActionCommand: RACCommand?
    dynamic var gameViewModel: GameViewModel?
    var gameInstructionsViewModel: GameInstructionsViewModel

    override init() {
        
        self.productsCollection = []
        self.productCategoriesCollection = []
        self.errorMessage = ""
        self.productsLoading = false
        self.gameInstructionsViewModel = GameInstructionsViewModel(instructionsFileName: "instructions")
        self.defaultGameModeStatus = true
        self.categoryIdentifier = ""
        self.showInstructionsView = false
        
        super.init()
        
        self.loadBaseCategories()
        
        if NSUserDefaults.standardUserDefaults().boolForKey(DefaultCategoriesStoredIndicator) == false {
            self.loadProductsFromAPIwithCategoryIdentifier(self.defaultCategoryIdentifier, caching: true)
        }
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
            self.defaultGameModeStatus = true
            self.loadBaseCategories()
            return RACSignal.empty()
        })
        
        gameInstructionsActionCommand = RACCommand(signalBlock: { [unowned self] (_) -> RACSignal! in
            self.showInstructionsView = true
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
    
    func searchWithSelectedCategoryIdentifier(categoryIdentifier: String, caching: Bool = false) {
        let storedProductsResult = ProductDatabaseStorer().productsFromDatabaseWith(categoryIdentifier, entityType: ModelType.Product)
        switch storedProductsResult {
            case .SuccessMantleModels(_):
                self.storeProducts(storedProductsResult, categoryIdentifier: categoryIdentifier, caching: caching)
            case let Result.Failure(error):
                self.errorMessage = "Failed to retrieve data from database with error \(error.localizedDescription)"
            default:
                self.errorMessage = "Unable to fetch records from database"
        }
    }
    
    func loadProductsFromAPIwithCategoryIdentifier(categoryIdentifier: String, caching: Bool = false) {
        self.productsLoading = true
        ProductApi.sharedInstance.productsWith(categoryIdentifier, format: .JSON, completion: { result in
            self.storeProducts(result, categoryIdentifier: categoryIdentifier, caching: caching)
        })
    }
    
    func storeProducts(result: Result, categoryIdentifier: String, caching: Bool = false) {
        self.productsLoading = false
        switch result {
            case let .SuccessMantleModels(models):
                if models.count > 0 {
                    if let models = models as? [Product] {
                        if caching == false {
                            productsCollection = models
                            self.categoryIdentifier = categoryIdentifier
                            self.gameViewModel = GameViewModel(products: self.productsCollection)
                        } else {
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: DefaultCategoriesStoredIndicator)
                        }
                        defaultGameModeStatus = categoryIdentifier == defaultCategoryIdentifier
                    } else if let models = models as? [ProductCategory] {
                        productCategoriesCollection = models                    
                    }
                } else {
                    self.loadProductsFromAPIwithCategoryIdentifier(categoryIdentifier)
                }
            case let .Failure(error):
                errorMessage = error.localizedDescription
            case .SuccessCoreDataModels(_):
                print("Retrieved Core data models")
        }
    }
}