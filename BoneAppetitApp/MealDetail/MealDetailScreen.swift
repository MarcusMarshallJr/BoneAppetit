//
//  RecipeDetailScreen.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/22/23.
//

import SwiftUI

/// The screen that shows all the details of a singular meal
struct MealDetailScreen: View {
   
   @EnvironmentObject var viewModel: AggregateMealsModel
   @Environment(\.presentationMode) var presentationMode
   
   /// The meal being presented to the user.
   var meal: Meal
   
   let imageHeight: CGFloat = 300
   let sidePadding: CGFloat = 30
   
   var body: some View {
      ZStack(alignment: .topLeading) {
         ScrollView {
            VStack {
               mealImage
               mealTitle
               Divider()
               ingredientSection
               Divider()
                  .padding(.vertical, sidePadding)
               directionsSection
            }.padding(.bottom, 150)
         }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("")
            .navigationBarHidden(true)
            .task {
               guard !meal.hasEssentialData else { return }
               await viewModel.getMeal(withID: meal.id)
            }
         
         BACircularButton(iconString: "arrow.left",
                          iconColor: Y900,
                          onTap: { presentationMode.wrappedValue.dismiss() }).padding(.leading)
         if let error = viewModel.presentedError {
            BAErrorView(error)
         }
      }
   }
}

//MARK: - Components
extension MealDetailScreen {
   private var mealImage: some View {
      BAAsyncImage(url: meal.imageURL) { phase in
         switch phase {
         case .empty:
            ProgressView()
         case .success(let image):
            image
               .resizable()
               .scaledToFill()
               .frame(height: imageHeight)
               .clipped()
            
         case .failure(_):
            N500
               .frame(height: imageHeight)
         @unknown default:
            fatalError()
         }
      }.frame(height: imageHeight)
   }
   
   private var mealTitle: some View {
      VStack(alignment: .leading, spacing: 6) {
         Text(meal.tags.joined(separator: ", "))
            .tracking(0.4)
            .brandFont(weight: .medium, color: N500)
            .multilineTextAlignment(.leading)
         Text(meal.name)
            .tracking(0.4)
            .brandFont(size: 25, weight: .bold, color: N900)
            .multilineTextAlignment(.leading)
      }.frame(maxWidth: .infinity, alignment: .leading)
         .padding(.top, sidePadding)
         .padding(.horizontal, sidePadding)
   }
   
   private var ingredientSection: some View {
      VStack(alignment: .leading) {
         SectionHeading(iconString: "checklist",
                        title: "Ingredients", subtitle: "Here's everything you'll need to make \(meal.name.lowercased()).")
         .padding(.vertical, sidePadding)
         
         ForEach(meal.ingredients.indices, id: \.self) { index in
            IngredientListItemView(name: meal.ingredients[index].name,
                                   measurement: meal.ingredients[index].measurement,
                                   imageURL: meal.ingredients[index].imageURL)
            
            if (index != meal.ingredients.count - 1) {
               Divider()
            }
         }
      }.padding(.horizontal, sidePadding)
   }
   
   private var directionsSection: some View {
      VStack(alignment: .leading) {
         SectionHeading(iconString: "menucard.fill",
                        title: "Instructions", subtitle: "Read all instructions first before beginning.")
         .padding(.vertical, sidePadding)
         
         ForEach(meal.instructions.indices, id: \.self) { index in
            InstructionListItemView(number: index + 1, text: meal.instructions[index])
            
            if (index != meal.ingredients.count - 1) {
               Divider()
            }
         }
         
      }.padding(.horizontal, sidePadding)
   }
}


//MARK: - Previews
//struct RecipeDetailScreen_Previews: PreviewProvider {
//   static var previews: some View {
//      MealDetailScreen(mealID: "52990")
//   }
//}
