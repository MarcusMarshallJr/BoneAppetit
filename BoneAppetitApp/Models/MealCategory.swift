//
//  MealCategory.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import Foundation

/// A model object to represent a Category from TheMealDB.
struct MealCategory: Identifiable, Decodable {
   
   /// The value of the `idCategory` property in the JSON.
   let id: String
   
   /// The value of the `strCategory` property in the JSON.
   let name: String
   
   /// A URL generated from the `strCategoryThumb` property in the JSON.
   let imageURL: URL?
   
   init(id: String, name: String, imageURL: URL?) {
      self.id = id
      self.name = name
      self.imageURL = imageURL
   }
   
   enum CodingKeys: CodingKey {
      case idCategory
      case strCategory
      case strCategoryThumb
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      self.id = try container.decode(String.self, forKey: .idCategory)
      self.name = try container.decode(String.self, forKey: .strCategory)
      self.imageURL = try? container.decode(URL.self, forKey: .strCategoryThumb)
      
   }
}

//MARK: - Class Properties
extension MealCategory {
   static let dessertCategory = MealCategory(id: "3", name: "Dessert", imageURL: URL(string: "https://www.themealdb.com/images/category/dessert.png"))
}
