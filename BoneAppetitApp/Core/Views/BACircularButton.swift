//
//  BACircularButton.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/22/23.
//

import SwiftUI


/// A reusable button view with app specific branding.
struct BACircularButton: View {
   
   /// The name of the SF Symbol to display inside the button.
   let iconString: String
   
   /// The font size of the SF Symbol inside the button.
   var iconSize: Double = 25
   
   /// The color of the SF Symbol inside the button.
   var iconColor: Color = P900
   
   /// The background color of the button.
   var backgroundColor: Color = N0
   
   /// The action that will take place when the button is pressed.
   var onTap: () -> Void = {}
   
   var body: some View {
      Button(action: onTap) {
         Image(systemName: iconString)
            .font(.system(size: iconSize))
            .foregroundColor(iconColor)
            .contentShape(Circle())
      }.frame(width: 45, height: 45)
         .background(backgroundColor)
         .clipShape(Circle())
   }
}


//MARK: - Previews
struct BACircularButton_Previews: PreviewProvider {
   static var previews: some View {
      BACircularButton(iconString: "arrow.left", 
                       iconColor: N0,
                       backgroundColor: P900)
   }
}
