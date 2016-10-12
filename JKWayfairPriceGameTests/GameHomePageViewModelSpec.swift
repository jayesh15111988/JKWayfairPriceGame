//
//  GameHomePageViewModelSpec.swift
//  JKWayfairPriceGame
//
//  Created by Jayesh Kawli on 10/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import JKWayfairPriceGame

class GameHomePageViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("Testing the Game Home page view model") {
            
            var gamePageViewModel = GameHomePageViewModel()
            
            beforeEach({
                gamePageViewModel = GameHomePageViewModel()
            })
            
            describe("All the parameters should have initial value after initialization", {
                it("All the class variable should have valid initial values", closure: {
                    expect(gamePageViewModel.productsCollection).to(beTruthy())
                    expect(gamePageViewModel.productsCollection.count).to(equal(0))
                    expect(gamePageViewModel.productCategoriesCollection).to(beTruthy())
                    expect(gamePageViewModel.productCategoriesCollection.count).to(equal(11))
                    expect(gamePageViewModel.errorMessage).toNot(beFalsy())
                    expect(gamePageViewModel.errorMessage).to(beEmpty())
                    expect(gamePageViewModel.productsLoading).to(beTrue())
                    expect(gamePageViewModel.defaultGameModeStatus).to(beTrue())
                    expect(gamePageViewModel.showInstructionsView).to(beFalse())
                    expect(gamePageViewModel.gameInstructionsViewModel).toNot(beNil())
                    expect(gamePageViewModel.categoryIdentifier).toNot(beFalsy())
                    expect(gamePageViewModel.categoryIdentifier).to(beEmpty())
                    expect(gamePageViewModel.defaultCategoryIdentifier).to(equal("419247"))
                    
                })
            })
            
            describe("This test will verify the creation of object models when app reads from the local json file", {
                it("Should correctly create correct and right number of object models out of dictionary read from the local json", closure: {
                    expect(gamePageViewModel.productCategoriesCollection).to(beTruthy())
                    expect(gamePageViewModel.productCategoriesCollection.count).to(equal(11))
                    
                    let productCategory1 = gamePageViewModel.productCategoriesCollection.first
                    expect(productCategory1?.categoryName).to(equal("Furniture"))
                    expect(productCategory1?.imageURL).to(equal(NSURL(string: "")))
                    expect(productCategory1?.categoryURL).to(equal(NSURL(string: "http://www.wayfair.com/Furniture-C45974.html")))
                    expect(productCategory1?.categoryIdentifier).to(equal(45974))
                    
                    let productCategory2 = gamePageViewModel.productCategoriesCollection.last
                    expect(productCategory2?.categoryName).to(equal("Seasonal"))
                    expect(productCategory2?.imageURL).to(equal(NSURL(string: "")))
                    expect(productCategory2?.categoryURL).to(equal(NSURL(string: "http://www.wayfair.com/Seasonal-C1859601.html")))
                    expect(productCategory2?.categoryIdentifier).to(equal(1859601))
                })
            })
            
            describe("Verifying the user actions", { 
                it("App should update appropriate flags when user executes certain actions", closure: {                    
                    expect(gamePageViewModel.showInstructionsView).to(beFalse())
                    gamePageViewModel.gameInstructionsActionCommand?.execute(nil)
                    expect(gamePageViewModel.showInstructionsView).to(beTrue())
                })
            })
            
            describe("Verifying the action to store the selected products", {
                it("Should update state correctly when the result with product models is passed to function", closure: { 
                    let products = try? [Product(dictionary: ["availability": "Available", "imageURL": "", "listPrice": 100, "manufacturerIdentifier": 200, "manufacturerName": "Random Manufacturer", "name": "A very good product", "salePrice": 50, "sku": "SK243"])]
                    if let products = products {
                        let result = Result.SuccessMantleModels(products)
                        gamePageViewModel.storeProducts(result, categoryIdentifier: "200")
                        expect(gamePageViewModel.productsCollection).to(equal(products))
                        expect(gamePageViewModel.productsLoading).to(beFalse())
                        expect(gamePageViewModel.categoryIdentifier).to(equal("200"))
                        expect(gamePageViewModel.gameViewModel).notTo(beNil())
                        expect(gamePageViewModel.defaultGameModeStatus).to(beFalse())
                        
                    }
                })

                it("Should update the error message string appropriately when storeProducts method encounters an error", closure: { 
                    let error = NSError(domain: "Wayfair", code: 300, userInfo: [NSLocalizedDescriptionKey: "Something went terribly wrong here"])
                    let result = Result.Failure(error)
                    gamePageViewModel.storeProducts(result, categoryIdentifier: "419247")
                    expect(gamePageViewModel.defaultGameModeStatus).to(beTrue())
                    expect(gamePageViewModel.errorMessage).to(equal("Something went terribly wrong here"))
                    
                })
            })
        }
    }
}
