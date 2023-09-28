//
//  Text+Extensions.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/26/23.
//

import SwiftUI

extension Text {
   ///A convenience modifer that easily applies standard brand font styling to Text.
   func brandFont(size: CGFloat = 16,
                    weight: Font.Weight = .regular,
                    color: Color = N900) -> some View {
      
      self.font(.system(size: size))
         .fontWeight(weight)
         .foregroundColor(color)
   }
}

