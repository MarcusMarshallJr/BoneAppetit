//
//  InstructionView.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import SwiftUI

/// A view that displays a singular instruction in a list.
struct InstructionListItemView: View {
   let number: Int
   let text: String
   
    var body: some View {
       HStack(alignment: .top, spacing: 12) {
          Image(systemName: "\(number).circle.fill")
             .font(.system(size: 16))
             .imageScale(.large)
             .foregroundColor(P900)
          Text(text)
             .brandFont(color: P900)
       }
    }
}

//MARK: - Previews
struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionListItemView(number: 3, text: "Put the flour, eggs, milk, 1 tbsp oil and a pinch of salt into a bowl or large jug, then whisk to a smooth batter.")
    }
}
