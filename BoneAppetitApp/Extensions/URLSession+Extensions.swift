//
//  URLSession+Extensions.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import Foundation

extension URLSession: HTTPClient {
   func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
      
      guard let (data, response) = try? await self.data(for: request) else {
         throw RCNetworkError.invalidData
      }
      
      guard let httpURLResponse = response as? HTTPURLResponse else {
         throw RCNetworkError.customError("Couldn't cast network response to HTTPURLResponse object.")
      }
      
      return (data, httpURLResponse)
   }
}
