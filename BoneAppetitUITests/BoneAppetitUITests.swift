//
//  BoneAppetitUITests.swift
//  BoneAppetitUITests
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import XCTest

final class RecipeUITests: XCTestCase {
   
   let app = XCUIApplication()
   
   override func setUp() {
      continueAfterFailure = false
      app.launch()
   }
   func testExample() throws {
      app.launch()
                  
      // Use XCTAssert and related functions to verify your tests produce the correct results.
   }
   
   
}
