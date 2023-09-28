//
//  RCErrorView.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import SwiftUI

/// A simple view that displays a `RCError` to the user.
struct BAErrorView: View {
   
   /// The `RCError` the user encountered.
   let rcError: RCError
   
   init(_ rcError: RCError) {
      self.rcError = rcError
   }
   
   var body: some View {
      HStack {
         Image(systemName: "exclamationmark.triangle.fill")
            .font(.system(size: 40))
            .foregroundColor(N0)
         VStack(alignment: .leading) {
            Text("Hmmm. Something went wrong.")
               .brandFont(weight: .bold, color: N0)
            Text(rcError.userMessage)
               .brandFont(color: N0)
         }
      }
      .frame(maxWidth: .infinity)
      .padding()
      .background(N900)
      
      
   }
}


//MARK: - Previews
struct BAErrorView_Previews: PreviewProvider {
   static var previews: some View {
      BAErrorView( RCError(RCNetworkError.invalidData))
   }
}

