//
//  AggregateViewModel.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import SwiftUI

@MainActor
class AggregateMealsModel: ObservableObject {
   
   /// The array of meal objects to available to the view.
   @Published var meals: [Meal] = []
   
   /// The category selected by the user
   @Published var selectedCategory: MealCategory = MealCategory.dessertCategory
   
   /// All categories the user can select from
   @Published var allCategories: [MealCategory] = []
   
   /// The values for the search field
   @Published var searchText = ""
   @Published var searchFieldFocused = false
   
   /// The error that should be presented to the user. If no error, nil.
   @Published var presentedError: RCError?
   
   /// The array of meal objects to presented to the view.
   var searchResults: [Meal] {
      if searchText.isEmpty {
         return meals
      } else {
         return meals.filter { $0.name.contains(searchText) }
      }
   }
   
   /// A stored instance of the MealService that provides data from the networking layer.
   let mealService: MealService
   
   init(mealService: MealService) {
      self.mealService = mealService
   }
   
   /// Retrieves decoded a meal object using the stored instance of `MealService`.
   func getMeal(withID id: String) async {
      let result = await mealService.loadMeal(withID: id)
      
      switch result {
      case .success(let meal):
         if let meal = meal,
            let indexToUpdate = meals.firstIndex(where: { $0.id == id }) {
            meals[indexToUpdate] = meal
         }
      case .failure(let networkError):
        presentedError = RCError(networkError)
      }
   }
   
   /// Retrieves decoded meal objects using the stored instance of `MealService`.
   func getMeals() async {
      let result = await mealService.loadMeals(ofCategory: selectedCategory.name)
      
      switch result {
      case .success(let allMeals):
         meals = sortMealsAlphabetically(allMeals)
      case .failure(let networkError):
         presentedError = RCError(networkError)
      }
   }
   
   /// Retrieves decoded meal category objects using the stored instance of `MealService`
   func getCategories() async {
      let result = await mealService.loadCategories()
      
      switch result {
      case .success(let categories):
         allCategories = categories
      case .failure(_):
         allCategories = [MealCategory.dessertCategory]
      }
   }
   
   /// Simulates a rating for the meal using its name as a hash value
   func getRating(name: String) -> Double {
      return Double(name.count % 3) + 2
   }
   
   /// Simulates a tag for the meal using its name as a hash value
   func getTag(name: String) -> String? {
      switch (name.count % 6) {
      case 0:
         return nil
      case 1:
         return "new"
      case 2:
         return "featured"
      case 3:
         return nil
      case 4:
         return "editors choice"
      case 5:
         return "reccomended"
      default:
         return nil
      }
   }
   
   /// Simulates a description for the meal using its name as a hash value.
   func getDescription(name: String) -> String {
      switch (name.count % 9) {
      case 0:
         return "Indulge in this flavorful meal that will leave you craving for more."
      case 1:
         return "This one's going to leave your taste buds dancing."
      case 2:
         return "Absolutely delicious. Super quick and easy."
      case 3:
         return "Simple to make. Perfect when you need something tasty and quick."
      case 4:
         return "Might be your next staple receipe."
      case 5:
         return "Takes a little bit of time, but it always worth the effort."
      case 6:
         return "Warm comfort food. Best served right out the oven."
      case 7:
         return "Healthy, delicious, and quick. Do we need to say more?"
      case 8:
         return "Perfect blend of savory, sweet, and tasty."
      case 9:
         return "Surprisingly easy to make."
      default:
         return ""
      
      }
   }
   
   /// Sorts a list of meals alphabetically
   private func sortMealsAlphabetically(_ meals: [Meal]) -> [Meal] {
      return meals.sorted{ $0.name < $1.name }
   }   
}
