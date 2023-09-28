//
//  Meal.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import Foundation

typealias Instruction = String
typealias Tag = String

/// A model object that represents a Meal from TheMealDB.
struct Meal: Identifiable {
   
   /// The value of the `idMeal` property in the JSON.
   let id: String
   
   /// The value of the `srtMeal` property in the JSON.
   let name: String
   
   /// The value of the `strInstructions` property in the JSON
   let instructions: [Instruction]
   
   /// A remapped array combining the `strIngredient` and `strMeasure`properties
   /// for each non null ingredient name and measurement in the JSON.
   let ingredients: [Ingredient]
   
   /// The value of the `strTags` property seperatated into individual strings
   let tags: [Tag]
   
   /// A URL generated from the `strMealThumb` property in the JSON.
   let imageURL: URL?
   
   
   var hasEssentialData: Bool {
      return !name.isEmpty && !instructions.isEmpty && !ingredients.isEmpty && imageURL != nil
   }
}



extension Meal: Decodable {
   
   enum CodingKeys: String, CodingKey {
      case idMeal
      case strMeal
      case strInstructions
      case strMealThumb
      case strTags
      
      case strIngredient1
      case strIngredient2
      case strIngredient3
      case strIngredient4
      case strIngredient5
      case strIngredient6
      case strIngredient7
      case strIngredient8
      case strIngredient9
      case strIngredient10
      case strIngredient11
      case strIngredient12
      case strIngredient13
      case strIngredient14
      case strIngredient15
      case strIngredient16
      case strIngredient17
      case strIngredient18
      case strIngredient19
      case strIngredient20
      
      case strMeasure1
      case strMeasure2
      case strMeasure3
      case strMeasure4
      case strMeasure5
      case strMeasure6
      case strMeasure7
      case strMeasure8
      case strMeasure9
      case strMeasure10
      case strMeasure11
      case strMeasure12
      case strMeasure13
      case strMeasure14
      case strMeasure15
      case strMeasure16
      case strMeasure17
      case strMeasure18
      case strMeasure19
      case strMeasure20
      
      
   }
   
   init(from decoder: Decoder) throws {
      
      //Get the enclosing container for the data
      let mealContainer = try decoder.container(keyedBy: CodingKeys.self)
      
      //Decode the simple properties
      let id = try mealContainer.decode(String.self, forKey: .idMeal)
      let name = try mealContainer.decode(String.self, forKey: .strMeal)
      let imageURL = try? mealContainer.decode(URL.self, forKey: .strMealThumb)
      
      //Decode the array properties
      var instructions: [String] = []
      if let instructionsString = try? mealContainer.decode(String.self, forKey: .strInstructions) {
         instructions = instructionsString.split{ $0 == "\r\n"}.map(String.init)
      }
      
      var tags: [String] = []
      if let tagsString = try? mealContainer.decode(String.self, forKey: .strTags) {
         tags = tagsString.components(separatedBy: ",")
      }
      
      //Map each non-null ingredient name with their measurement
      var ingredients: [Ingredient] = []
      for i in 1...20 {
         if let ingredientNameKey = CodingKeys(rawValue: "strIngredient\(i)"),
            let ingredientMeasurementKey = CodingKeys(rawValue: "strMeasure\(i)"),
            let ingredientName = try? mealContainer.decode(String.self, forKey: ingredientNameKey),
            let ingredientMeasure = try? mealContainer.decode(String.self, forKey:  ingredientMeasurementKey) {
            
            if !ingredientName.isEmpty && !ingredientMeasure.isEmpty {
               let ingredient = Ingredient(name: ingredientName, measurement: ingredientMeasure)
               ingredients.append(ingredient)
            }
         }
      }
            
      //Initalize all the values
      self.id = id
      self.name = name
      self.instructions = instructions
      self.imageURL = imageURL
      self.tags = tags
      self.ingredients = ingredients
   }
}
