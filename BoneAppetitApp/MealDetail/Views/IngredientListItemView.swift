//
//  IngredientView.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import SwiftUI

/// A view that displays a sinuglar ingredient in a list.
struct IngredientListItemView: View {
   
   let name: String
   let measurement: String
   let imageURL: URL?
   
   let imageHeight: CGFloat = 30
   
    var body: some View {
       HStack() {
          Text(name)
             .brandFont(weight: .medium)
             .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
             .multilineTextAlignment(.leading)
          Text(measurement)
             .brandFont(color: N500)
          Spacer()
          BAAsyncImage(url: imageURL) { phase in
             switch phase {
             case .empty:
                ProgressView()
             case .success(let image):
                image
                   .resizable()
                   .scaledToFill()
                   .frame(width: imageHeight,
                          height: imageHeight)
                   .clipped()
                   
             case .failure(_):
                Color.clear
                   .frame(width: imageHeight,
                          height: imageHeight)
             @unknown default:
                fatalError()
             }
          }
       }.frame(minHeight: imageHeight)
    }
}

//MARK: - Previews
struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
       IngredientListItemView(name: "Flour", measurement: "1 Cup", imageURL: Endpoint.ingredientImage(named: "Flour").url)
    }
}
