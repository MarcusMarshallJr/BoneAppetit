//
//  CategoryScreen.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import SwiftUI

/// The screen that lists all the meals in a specific category
struct CategoryScreen: View {
   
   @EnvironmentObject var viewModel: AggregateMealsModel
   
   var body: some View {
      NavigationView() {
         VStack(spacing: 0) {
            ZStack {
               header
               errorView
            }
            searchField
            CategoryTabs(selectedCategory: $viewModel.selectedCategory, categories: viewModel.allCategories)
            Divider()
            listOfReceipes
            
         }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(N0)
            .task {
               guard viewModel.allCategories.count < 1 else { return }
               await viewModel.getCategories()
            }
            .task(id: viewModel.selectedCategory.id) {
               await viewModel.getMeals()
            }
      }
   }
}

//MARK: - Components
extension CategoryScreen {
   private var header: some View {
      HStack {
         Image("dog_by_oksana_latysheva_the_noun_project")
            .resizable()
            .scaledToFit()
            .frame(height: 30)
         HStack(spacing: 3) {
            Text("Bone")
               .tracking(1)
               .brandFont(size: 20, weight: .bold)
            Text("Appétit".uppercased())
               .brandFont(size: 21, weight: .bold)
         }
      }
   }
   private var errorView: some View {
      VStack {
         if let error = viewModel.presentedError {
            BAErrorView(error)
         }
      }
   }
   private var searchField: some View {
      BASearchField(placeholderText: "Filter Recipes",
                    searchText: $viewModel.searchText,
                    isFocused: $viewModel.searchFieldFocused,
                    onCommit: { })
      .padding()
      .padding(.bottom, 4)
   }
   private var listOfReceipes: some View {
      List {
         if viewModel.meals.isEmpty {
            Text("No \(viewModel.selectedCategory.name.lowercased()) receipes in the database.")
               .brandFont()
         } else if viewModel.searchResults.isEmpty {
            Text("No \(viewModel.selectedCategory.name.lowercased()) recipes named '\(viewModel.searchText)'")
               .brandFont()
         } else {
            ForEach(viewModel.searchResults) { meal in
               NavigationLink(destination: MealDetailScreen(meal: meal)) {
                  MealListItemView(title: meal.name,
                                   subtitle: viewModel.getDescription(name: meal.name),
                                   overline: viewModel.getTag(name: meal.name),
                                   rating: viewModel.getRating(name: meal.name),
                                   imageURL: meal.imageURL)
               }
            }
         }
      }.background(N0)
         .clipShape(RoundedRectangle(cornerRadius: 30))
         .edgesIgnoringSafeArea(.bottom)
         .listStyle(.plain)
      
   }
}

//MARK: - Previews
struct CategoryScreen_Previews: PreviewProvider {
   static var previews: some View {
      CategoryScreen()
         .environmentObject(AggregateMealsModel(mealService:
                                                   MealService(client:
                                                                  AuthenticatedHTTPClient(client: URLSession.shared))))
   }
}
