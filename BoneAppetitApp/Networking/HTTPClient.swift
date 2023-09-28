//
//  HTTPClient.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import Foundation

/// A protocol using only Foundation types that defines methods any HTTPClient must adopt.
/// 
/// This allows any complexity associated with requesting information from an endpoint to be encapsulated.
/// For this simple application only one method is required.
protocol HTTPClient {
   
   /// Downloads the contents of a URL using the provided URL Request and delivers the data asynchronously.
   /// - Parameter request: The URL Request object that provides the URL. This can be easily generated from the `makeRequest` function of an `Endpoint` instance.
   /// - Returns: An asynchronously-delivered tuple that contains the URL contents as a `Data` instance, and an instance of the HTTP specific `HTTPURLResponse` class rather than the more generic `URLResponse`.
   func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}


/// A concrete implementation of the HTTPClient protocol that wraps the fetch request with the an API Key.
///
/// Wrapping or decorating the HTTPClient in this way allows us to easily encapsulate the details of authentication
/// and adjust if another type of authentication was needed for the API.
struct AuthenticatedHTTPClient: HTTPClient {
   
   /// The client instance we want to wrap with an API key
   let client: HTTPClient
   
   /// A computed property that retrieves the API key from a plist file made specificly for the MealDB API.
   ///
   /// The public API key for TheMealDB isn't secret, but in a real app we wouldn't want that key just set to a constant in the code.
   /// Using a computed property within the context the key is needed is a safer and more encapsulated approach.
   /// Moreover, doing it this way lets us safely unwrap it and error out if it's not available beacuse not having the API key would be a coding error.
   private var apiKey: String {
      get {
         guard let filePath = Bundle.main.path(forResource: "TheMealDB-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'TheMealDB.plist' that should contain the API Key.")
         }
         
         let plist = NSDictionary(contentsOfFile: filePath)
         
         guard let apiKeyString = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' with value of type String in 'TheMealDB-Info.plist'.")
         }
         return apiKeyString
      }
   }
   
   /// Adds the API key to the client's request, downloads the contents of a URL using the provided URL Request, and delivers the data asynchronously.
   /// - Parameter request: The URL Request object that provides the URL. This can be easily generated from the `makeRequest` function of an `Endpoint` instance.
   /// - Returns: An asynchronously-delivered tuple that contains the URL contents as a `Data` instance, and an instance of the HTTP specific `HTTPURLResponse` class rather than the more generic `URLResponse`.
   func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
      var signedRequest = request
      signedRequest.addValue(apiKey, forHTTPHeaderField: "api_key")
      
      return try await client.fetch(signedRequest)
   }
}
