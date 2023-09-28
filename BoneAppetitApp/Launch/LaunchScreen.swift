//
//  LaunchScreen.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/27/23.
//

import SwiftUI

/// The screen shown when the app first launches
struct LaunchScreen: View {
   
   /// The scale value of the dog image. Oscilates between 1.0 and 0.75
   @State var scale = 1.0
   
   var body: some View {
      VStack {
         Spacer()
         VStack {
            Image("dog_by_oksana_latysheva_the_noun_project")
               .scaleEffect(scale)
            Text("Bone")
               .tracking(1)
               .brandFont(size: 40, weight: .bold)
            Text("Appétit".uppercased())
               .brandFont(size: 21, weight: .bold)
         }
         Spacer()
         Text("Dog image designed Oksana Latysheva\nfrom The Noun Project")
            .brandFont(color: N500)
            .multilineTextAlignment(.center)
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(N0)
         .onAppear {
            let baseAnimation = Animation.easeInOut(duration: 1)
            let repeated = baseAnimation.repeatForever(autoreverses: true)
            
            withAnimation(repeated) {
               scale = 0.75
            }
         }
   }
}

struct LaunchScreen_Previews: PreviewProvider {
   static var previews: some View {
      LaunchScreen()
   }
}

