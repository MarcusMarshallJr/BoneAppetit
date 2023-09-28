//
//  RCNetworkError.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/25/23.
//

import Foundation


/// A type that represents an error in the Networking Layer,
enum RCNetworkError: Error {
   case invalidURL(String)
   case invalidResponse(Int)
   case invalidData
   case parsingFailed
   case customError(String)
   
   
   /// The complete error message to present to a user.
   var fullErrorMessage: String {
      return userGuidance + supportErrorMessage
   }
   
   /// A user-friendly string that can help a user recover from or get help with an error.
   var userGuidance: String {
      return "There was an error downloading meals. Contact support, then tell them: "
   }
   
   /// The internal issue the networking layer encountered.
   var supportErrorMessage: String {
      switch self {
      case .invalidURL(let urlString):
         return "'Downloading from URL \(urlString) failed'."
      case .invalidResponse(let responseCode):
         return "'Error Code: \(responseCode)'."
      case .invalidData:
         return "'Data retrieved from TheMealDB was invalid'."
      case .parsingFailed:
         return "'JSON parsing failed to decode data.'"
      case .customError(let errorString):
         return "'\(errorString)'"
      }
   }
}
