//
//  DraggableAndScalable.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct DraggableAndScalable: ViewModifier {
  @State private var previousScale: CGFloat?
  @State private var scale: CGFloat = 1
  @State private var offset: CGPoint = .zero
  @State private var previousTranslation: CGSize?
  
  func body(content: Content) -> some View {
    let dragGesture = DragGesture().onChanged { value in
      if let translation = previousTranslation {
        // Drag changed
        let delta = CGSize(width: value.translation.width - translation.width,
                           height: value.translation.height - translation.height)
        offset.x += delta.width
        offset.y += delta.height
        previousTranslation = value.translation
      } else {
        // Drag started
        previousTranslation = value.translation
      }
    }
    .onEnded { _ in
      // Drag ended
      previousTranslation = nil
    }
    let scaleGesture = MagnificationGesture()
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
      }
    content
      .scaleEffect(CGSize(width: scale, height: scale), anchor: .center)
      .offset(x: offset.x, y: offset.y)
      .gesture(dragGesture
                .simultaneously(with: scaleGesture)
               
      )
      
  }
}

extension View {
  func draggableAndScaleable() -> some View {
    self
      .modifier(DraggableAndScalable())
  }
}
