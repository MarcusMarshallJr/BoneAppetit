//
//  MealListItemView.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import SwiftUI

/// A view that represents a singular meal in a list.
struct MealListItemView: View {
   
   var title: String
   var subtitle: String?
   var overline: String?
   var rating: Double?
   var imageURL: URL?
   
   let imageHeight: CGFloat = 92
   
   var body: some View {
      HStack(alignment: .top ,spacing: 10) {
         mealInformation
         Spacer()
         mealImage
      }
   }
}

//MARK: - Components
extension MealListItemView {
   var mealInformation: some View {
      VStack(alignment: .leading, spacing: 6) {
         if let overline = overline {
            Text(overline.uppercased())
               .brandFont(size: 12, weight: .bold, color: Y900)
         }
         Text(title)
            .brandFont(weight: .medium, color: N900)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
         Text(subtitle ?? "")
            .brandFont(size: 15, color: N500)
            .multilineTextAlignment(.leading)
            .lineLimit(2)         
      }
   }
   var mealImage: some View {
      ZStack(alignment: .bottom) {
         BAAsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
               ProgressView()
                  .frame(height: imageHeight)
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
         }
         if let rating = rating {
            LinearGradient(colors: [N900, N900.opacity(0)],
                           startPoint: .bottom,
                           endPoint: .top)
            .frame(maxHeight: 30)
            HStack(spacing: 5) {
               Spacer()
               Text(String(format: "%.1f", rating))
                  .brandFont(size: 13, weight: .black, color: Y900)
               Image(systemName: "star.fill")
                  .font(Font.system(size: 13))
                  .foregroundColor(Y900)
                  .padding(.trailing, 2)
            }.frame(width: imageHeight, height: imageHeight / 3)
         }
      }
      .frame(width: imageHeight, height: imageHeight)
      .clipShape(RoundedRectangle(cornerRadius: 12))
   }
}

//MARK: - Previews
//struct MealListItemView_Previews: PreviewProvider {
//   static var previews: some View {
//      MealListItemView(title: "Apple & Blackberry Crumble",
//                       subtitle: "Flour, Butter, Milk, Eggs, & Sunflower oil.",
//                       overline: "Sweet, Fruit",
//                       rating: 4.0,
//                       imageURL: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"))
//   }
//}
