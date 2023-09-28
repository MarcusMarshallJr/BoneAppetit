//
//  TheMealDBMapper.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import Foundation

/// Soley responsible for mapping downloaded data from TheMealDB into an array of model objects as long as it receieves a valid response.
///
/// TheMealDB provides an array of JSON objects under a singular key in its response data.
/// To accomodate for this and keep things generic, the `map` function requires a `jsonArrayKey`
/// property that will parse the array from the object before decoding each individual model object.
struct TheMealDBMapper {
   
   /// Maps downloaded data into model objects as a long ast it recieves a valid response.
   /// - Parameters:
   ///   - data: The fetched data that should be mapped
   ///   - response: The `HTTPURLResponse` from the data.
   ///   - jsonArrayProperty: The "top level" JSON array property that holds the array of JSON data objects
   /// - Returns: An array of decoded model objects
   ///
   ///See documentation for the ``TheMealDBMapper`` struct for more info.
   static func map<T: Decodable>(data: Data,
                      response: HTTPURLResponse,
                      jsonArrayProperty: String) throws -> [T] {
   
      switch response.statusCode {
      case 200...299:
         var modelObjectArray = [T]()
         
         do {
            let jsonData = try JSONSerialization.jsonObject(with: data)
            if let jsonDataDictionary = jsonData as? [String: Any],
               let jsonDataArray = jsonDataDictionary[jsonArrayProperty] as? [Any] {
               
               for object in jsonDataArray {
                  let jsonData = try JSONSerialization.data(withJSONObject: object)
                  let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                  modelObjectArray.append(decodedObject)
               }
            }
         } catch {
            throw RCNetworkError.parsingFailed
         }
         
         return modelObjectArray
         
      default:
         throw RCNetworkError.invalidResponse(response.statusCode)
      }
   }
}
