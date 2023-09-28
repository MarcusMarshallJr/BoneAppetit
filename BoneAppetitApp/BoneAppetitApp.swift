//
//  BoneAppetitApp.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/21/23.
//

import SwiftUI

@main
struct BoneAppetitApp: App {
   
   /// A single source of truth for this Client/Server application.
   @StateObject var aggregateMealsModel = AggregateMealsModel(mealService:MealService(client: AuthenticatedHTTPClient(client: URLSession.shared)))
   
   /// A boolean to simulate initial app loading in a production app
   ///
   /// Could be used to load analytic data, clean up after an app update, etc.
   @State var isLoading = true
   
   var body: some Scene {
      WindowGroup {
         ZStack {
            CategoryScreen()
               .environmentObject(aggregateMealsModel)
            if isLoading {
               LaunchScreen()
            }
         }
         .task {
            //This task could be used to load analytic data, clean up after an app update, etc.
            try? await Task.sleep(nanoseconds: 2_000_500_000)
            isLoading = false
         }
      }
   }
}
