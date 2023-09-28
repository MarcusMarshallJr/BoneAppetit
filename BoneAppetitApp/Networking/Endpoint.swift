//
//  Endpoint.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import Foundation

/// A structure that generates a valid URLRequest for TheMealDB's endpoints given a path, query items, etc.
struct Endpoint {
   
   ///The URL path relative to the base url  `https://themealdb.com` provided as a string. The proceeding slash will be added automatically.
   var path: String
   
   ///An array of query items to add to the end of the generated URL. By default, no query items are used.
   var queryItems: [URLQueryItem] = []
   
   ///Optionally provide a "top level" JSON Array property. The name of this `String` lets any endpoint mapper
   ///or generic API mapper know what property in the returned json data will hold the array of data objects.
   var jsonArrayProperty: String? = nil
   
   ///The generated URL struct relative to the base url `https://themealdb.com` unwrapped and ready to use.
   var url: URL {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "themealdb.com"
      components.path =  "/" + path
      components.queryItems = queryItems
      
      guard let url = components.url else {
         preconditionFailure("Could not generate a URL from the following components: \(components)")
      }
      
      return url
   }
   
   /// Generates a URL request for the URL the `Endpoint` represents.
   /// - Returns: A `URLRequest` that can be used to download data using any `HTTPClient`'s fetch method
   func makeRequest() -> URLRequest {
      return URLRequest(url: url)
   }
}

//MARK: - Static Methods
extension Endpoint {
   
   /// The endpoint that can retrieve all meals in a given category.
   /// - Parameter categoryName: The name of the category as a String that the URL should reference. Set this name as a query parameter for the URL.
   /// - Returns: An `Endpoint` structure that can generate a valid URL to use in the Networking Layer.
   static func category(named categoryName: String) -> Self {
      Endpoint(path: "api/json/v1/1/filter.php",
               queryItems: [URLQueryItem(name: "c",
                                         value: categoryName)],
               jsonArrayProperty: "meals")
   }
   
   /// The endpoint that can retrieve a list of all categories available from TheMealDB.
   ///  - Returns: An Endpoint structure that can generate a valid URL to use in the Networking Layer.
   static var allCategories: Self {
      Endpoint(path: "api/json/v1/1/categories.php",
               jsonArrayProperty: "categories")
   }
   
   /// The endpoint that can retrieve the details of one specific meal given the ID.
   /// - Parameter mealID: A string ID of digits that represents a specific meal from TheMealDB
   /// - Returns: An Endpoint structure that can generate a valid URL to use in the Networking Layer.
   static func meal(withID mealID: String) -> Self {
      Endpoint(path: "api/json/v1/1/lookup.php",
               queryItems: [URLQueryItem(name: "i",
                                         value: mealID)],
               jsonArrayProperty: "meals")
   }
   
   /// The endpoint that can retrieve a small thumbnail of an Ingredient.
   /// - Parameter name: The ingredient name for the image
   /// - Returns: An Endpoint structure that can be used in an AsyncImage network request.
   static func ingredientImage(named name: String) -> Self {
      Endpoint(path: "images/ingredients/\(name)-Small.png")
   }
}
