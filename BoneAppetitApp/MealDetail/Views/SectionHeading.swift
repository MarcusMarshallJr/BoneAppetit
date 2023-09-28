//
//  SectionHeading.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/22/23.
//

import SwiftUI

/// A view that displays a heading on the `MealDetailScreen`
struct SectionHeading: View {
   
   let iconString: String
   let title: String
   var subtitle: String?
   
   var body: some View {
      VStack(alignment: .leading, spacing: 12) {
         HStack {
            Image(systemName: iconString)
               .font(.system(size: 20))
               .foregroundColor(N900)
            Text(title.uppercased())
               .tracking(0.5)
               .brandFont(size: 20, weight: .bold, color: N900)
            Spacer()
         }
         if let subtitle = subtitle {
            Text(subtitle)
               .brandFont(color: N500)
               .multilineTextAlignment(.leading)
         }
      }
   }
}

//MARK: - Previews
struct SectionHeading_Previews: PreviewProvider {
   static var previews: some View {
      SectionHeading(iconString: "menucard.fill", 
                     title: "Instructions",
                     subtitle: "Here’s everything you’ll need to make Pancakes.")
   }
}
