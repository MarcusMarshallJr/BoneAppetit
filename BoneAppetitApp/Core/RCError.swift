//
//  RCError.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import Foundation

/// A type that can represent any error in the app.
struct RCError: Identifiable {
   
   /// A unique value to indentify the error by.
   let id = UUID()
   
   /// The wrapped error.
   let error: Error
   
   /// A string to provide guidance to a user when recieving the error.
   let userMessage: String
   
   init(_ error: Error, userMessage: String) {
      self.error = error
      self.userMessage = userMessage
   }
   
   init(_ networkError: RCNetworkError) {
      self.error = networkError
      self.userMessage = networkError.fullErrorMessage
   }
}
