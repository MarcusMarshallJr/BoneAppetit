//
//  BoneAppetitTests.swift
//  BoneAppetitTests
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import XCTest
@testable import BoneAppetit

final class RecipeTests: XCTestCase {
   
   private var client: HTTPClient!
   private var mealService: MealService!
   
   override func setUp() {
      super.setUp()
      
      client = AuthenticatedHTTPClient(client: URLSession.shared)
      mealService = MealService(client: client)
   }
   
   @MainActor
   /// Tests the behavior of `CategoryScreenViewModel` to enusre
   /// a list of meals is loaded into the meals variable.
   func testListOfMealsIsLoaded() async throws {
      
      let viewModel = AggregateMealsModel(mealService: mealService)
      await viewModel.getMeals()
      
      XCTAssertTrue(viewModel.meals.count > 0, "No meals are being loaded.")
      
   }
   
   
   @MainActor
   /// Tests the behavior of the `CategoryScreenViewModel` to ensure
   /// the list of returned meals is sorted alphabetically per the coding challenge
   func testAlphabeticalSorting() async throws {
      
      let authenticatedClient = AuthenticatedHTTPClient(client: URLSession.shared)
      let mealService = MealService(client: authenticatedClient)
      let viewModel = AggregateMealsModel(mealService: mealService)
      
      
      await viewModel.getMeals()
      guard viewModel.meals.count > 1 else { return }
      
      for i in 1..<viewModel.meals.count {
         let previous = viewModel.meals[i - 1].name
         let current = viewModel.meals[i].name
         XCTAssertTrue(previous < current, "\(previous) does not come before \(current) in the alphabet")
      }
   }
   
}
