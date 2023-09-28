//
//  RCSearchField.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/27/23.
//

import SwiftUI

struct BASearchField: View {
   
   var placeholderText: String = "Search"
   
   @Binding var searchText: String
   @Binding var isFocused: Bool
   
   var onCommit: () -> Void = { }
   
   var body: some View {
      
      return (
         VStack {
            ZStack(alignment: .trailing) {
               HStack {
                  Image(systemName: "magnifyingglass")
                     .imageScale(.large)
                     .font(Font.system(size: 16))
                     .foregroundColor(N900)
                  TextField( placeholderText,
                             text: self.$searchText,
                             onCommit: handleCommit)
                     .font(
                        .system(size: 16)
                        .weight(.medium)
                     )
                     .foregroundColor(N900)
                     .submitLabel(.search)
               }
               .padding(11)
               .background(N200)
               .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
               .padding(11)
               
               if !self.searchText.isEmpty {
                  Button(action:{ self.searchText = "" }) {
                     Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                  }
                  .padding(.trailing, 18)
               }
            }
            
         }.background(Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .baShadow(radius: 4))
         
         
      )
   }

   private func handleCommit() {
      isFocused = false
      onCommit()
   }
}

//MARK: - Previews
struct BASearchField_Previews: PreviewProvider {
    static var previews: some View {
       BASearchField(searchText: .constant(""), isFocused: .constant(false))
    }
}
