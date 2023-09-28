//
//  CategoryTabs.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import SwiftUI

struct CategoryTabs: View {
   @Binding var selectedCategory: MealCategory
   var categories: [MealCategory] = []

   
    var body: some View {
       ScrollView(.horizontal, showsIndicators: false) {
          HStack {
             ForEach(categories) { category in
                VStack {
                   BAAsyncImage(url: category.imageURL) { phase in
                      switch phase {
                      case .empty:
                         ProgressView()
                      case .success(let image):
                         image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            
                      case .failure(_):
                         N500
                      @unknown default:
                         fatalError()
                      }
                   }.frame(width: 30, height: 30)
                      
                   Text(category.name)
                      .brandFont(weight: isSelected(category) ? .bold : .regular,
                                 color: N900)
                      .padding(.horizontal, 6)
                   RoundedRectangle(cornerRadius: 3)
                      .frame(height: isSelected(category) ? 2 : 0)
                      .foregroundColor(Y900)
                      
                }.padding(.horizontal, 10)
                   .onTapGesture {
                      withAnimation(.easeInOut(duration: 0.2)) {
                         selectedCategory = category
                      }
                   }
             }
          }.padding(.horizontal)
       }
    }
}


//MARK: - Functions
extension CategoryTabs {
   func isSelected(_ category: MealCategory) -> Bool {
      return category.name == selectedCategory.name
   }
}

//MARK: - Previews
struct CategoryTabs_Previews: PreviewProvider {
    static var previews: some View {
       CategoryScreen()
    }
}
