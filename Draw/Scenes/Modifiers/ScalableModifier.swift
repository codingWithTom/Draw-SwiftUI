//
//  ScalableModifier.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct ScalableModifier: ViewModifier {
  @State private var previousScale: CGFloat?
  @State private var scale: CGFloat = 1
  
  func body(content: Content) -> some View {
    content
      .scaleEffect(CGSize(width: scale, height: scale), anchor: .center)
      .gesture(MagnificationGesture()
                .onChanged { gesture in
                  if let previousScale = self.previousScale {
                    let delta = gesture.magnitude - previousScale
                    scale += delta
                    self.previousScale = gesture.magnitude
                  } else {
                    previousScale = gesture.magnitude
                  }
                }
                .onEnded { _ in
                  previousScale = nil
                })
  }
}

extension View {
  func scaleable() -> some View {
    self
      .modifier(ScalableModifier())
  }
}
