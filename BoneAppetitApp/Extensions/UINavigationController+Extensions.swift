//
//  UINavigationController+Extensions.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/23/23.
//

import UIKit

extension UINavigationController {
   //This workaround allows the swipe back gesture for a `NavigationView`
   // when the back button is hidden.
   override open func viewDidLoad() {
      super.viewDidLoad()
      interactivePopGestureRecognizer?.delegate = nil
   }
}
