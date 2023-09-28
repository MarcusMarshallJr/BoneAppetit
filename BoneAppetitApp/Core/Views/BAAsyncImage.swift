//
//  BAAsyncImage.swift
//  BoneAppetit
//
//  Created by Marcus Marshall, Jr on 9/28/23.
//

import SwiftUI

/// A wrapper around SwiftUI's AsyncImage that provides basic caching support.
struct BAAsyncImage<Content>: View where Content: View {
   
   private let url: URL?
   private let scale: CGFloat
   private let transaction: Transaction
   private let content: (AsyncImagePhase) -> Content
   
   init(url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
      self.url = url
      self.scale = scale
      self.transaction = transaction
      self.content = content
   }
   
   
   var body: some View {
      if let cachedImage = ImageCache[url] {
         content(.success(cachedImage))
      } else {
         AsyncImage(url: url, 
                    scale: scale,
                    transaction: transaction) { phase in
            cacheAndRender(phase)
         }
      }
   }
}

//MARK: - Functions
extension BAAsyncImage {
   func cacheAndRender(_ phase: AsyncImagePhase) -> some View {
      if case.success(let image) = phase {
         ImageCache[url] = image
      }
      
      return content(phase)
   }
}

//MARK: - Private Classes
fileprivate class ImageCache {
   static private var cache = [URL: Image]()
   
   static subscript(url: URL?) -> Image? {
      get {
         guard let url = url else { return nil }
         return ImageCache.cache[url]
      }
      set {
         guard let url = url else { return }
         
         ImageCache.cache[url] = newValue
      }
   }
}


//MARK: - Previews
struct BAAsyncImage_Previews: PreviewProvider {
   static var previews: some View {
      BAAsyncImage(url: Endpoint.ingredientImage(named: "Flour").url) {
         phase in
         switch phase {
         case .empty:
            ProgressView()
         case .success(let image):
            image
         case .failure(_):
            Text("Error")
         @unknown default:
            fatalError()
         }
      }
   }
}

