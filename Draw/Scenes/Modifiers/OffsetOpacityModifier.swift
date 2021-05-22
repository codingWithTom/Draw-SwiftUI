//
//  OffsetOpacityModifier.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct OffsetOpacityModifier: ViewModifier {
  let offset: CGPoint
  let opacity: Double
  
  func body(content: Content) -> some View {
    content
      .offset(x: offset.x, y: offset.y)
      .opacity(opacity)
  }
}
