//
//  Ingredient.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/25/23.
//

import Foundation

/// A model object that represents an ingredient in a meal
struct Ingredient: Identifiable {
   
   /// A unique ID used to make Ingredients easy to display in a ForEach loop in SwiftUI
   let id = UUID()
   
   /// The name of the ingredient
   let name: String
   
   /// The measurement for the ingredient
   let measurement: String
   
   /// The URL needed to retrieve an image from TheMealDB
   var imageURL: URL {
      Endpoint.ingredientImage(named: name).url
   }
}
