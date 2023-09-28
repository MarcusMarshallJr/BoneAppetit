//
//  View+Extensions.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/27/23.
//

import SwiftUI

extension View {
   ///A convenience modifer that easily applies a standard shadow to a view.
   func baShadow(radius: CGFloat = 8,
                 x: CGFloat = 0,
                 y: CGFloat = 2) -> some View {
       self
           .shadow(color: nightShadow,
                   radius: radius,
                   x: x,
                   y: y)
   }
}

