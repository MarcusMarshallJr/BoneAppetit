//
//  MealService.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import Foundation

/// A service that uses an `HTTPClient` to make requests and provide decoded `Meal` model objects.
struct MealService {
   
   /// The client the service should use when fetching data.
   let client: HTTPClient
   
   /// Asynchronously returns an array of decoded `Meal` objects in a given category.
   /// - Parameter categoryName: The name of the category that all returned meals should exist under.
   /// - Returns: An array od decodede `Meal` model objects. If no Meals exist for the category
   /// or some other error happens, returns empty array.
   func loadMeals(ofCategory categoryName: String) async -> Result<[Meal], RCNetworkError> {
      
      let endpoint = Endpoint.category(named: categoryName)
      
      guard let endpointArrayProperty = endpoint.jsonArrayProperty else {
         fatalError()
      }
      
      return await loadData(withRequest: endpoint.makeRequest(),
                                    endpointArrayProperty: endpointArrayProperty)
   }
   
   /// Asynchronously  returns a decoded `Meal` object given is database ID string.
   /// - Parameter ID: The database ID of the meal that should be retrieved and decoded.
   /// - Returns: A decoded `Meal` model object. If no Meal exists for the id or some other error happens, returns `nil`.
   func loadMeal(withID ID: String) async -> Result<Meal?, RCNetworkError> {
      
      let endpoint = Endpoint.meal(withID: ID)
      
      guard let endpointArrayProperty = endpoint.jsonArrayProperty else {
         fatalError("No json array property provided for endpoint \(endpoint.url.absoluteString)")
      }
      
      let result: Result<[Meal], RCNetworkError> = await loadData(withRequest: endpoint.makeRequest(),
                                          endpointArrayProperty: endpointArrayProperty)
      
      switch result {
      case .success(let meals):
         return .success(meals.first)
      case .failure(let failure):
         return .failure(failure)
      }
   }
   
   func loadCategories() async -> Result<[MealCategory], RCNetworkError> {
      let endpoint = Endpoint.allCategories
      
      guard let endpointArrayProperty = endpoint.jsonArrayProperty else {
         fatalError("No json array property provided for endpoint \(endpoint.url.absoluteString)")
      }
      
      let result: Result<[MealCategory], RCNetworkError> = await loadData(withRequest: endpoint.makeRequest(),
                                                                          endpointArrayProperty: endpointArrayProperty)
      
      switch result {
      case .success(let categories):
         return .success(categories)
      case .failure(let failure):
         return .failure(failure)
      }
   }
   
   /// Fetches data using the provided `URLRequest` then decodes it into an array of decoded objects
   /// - Parameters:
   ///   - request: The URL Request object that provides the URL. This can be easily generated from the `makeRequest` function of an `Endpoint` instance.
   ///   - endpointArrayProperty: The "top level" JSON key in the returned data that holds the array of JSON objects that should be decoded.
   /// - Returns: An array of decoded model objects
   private func loadData<T: Decodable>(withRequest request: URLRequest,
                                 endpointArrayProperty: String) async -> Result<[T], RCNetworkError> {
      do {
         let (data, response) = try await client.fetch(request)
         let mappedData: [T] = try TheMealDBMapper.map(data: data,
                                                     response: response,
                                                     jsonArrayProperty: endpointArrayProperty)
         return .success(mappedData)
      } catch {
         if let networkError = error as? RCNetworkError {
            return .failure(networkError)
         } else {
            return .failure(.customError(error.localizedDescription))
         }
      }
   }
   
}

