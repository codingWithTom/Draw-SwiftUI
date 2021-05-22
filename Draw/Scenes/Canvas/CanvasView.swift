//
//  CanvasView.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct CanvasView: View {
  
  @State private var shapes: [AnyView] = []
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.clear)
      TwoFingerGestureView(numberOfTaps: 2) {
        withAnimation {
          shapes = []
        }
      }
      ForEach(shapes.indices, id: \.self) {
        shapes[$0]
          .draggableAndScaleable()
          .transition(.modifier(
                        active: OffsetOpacityModifier(offset: getRandomOffset(), opacity: 0.0),
                        identity: OffsetOpacityModifier(offset: .zero, opacity: 1.0))
          )
      }
    }
    .contentShape(Rectangle())
    .onTapGesture(count: 2) {
      shapes.append(Shapes.getRandomShape())
    }
  }
  
  func getRandomOffset() -> CGPoint {
    return CGPoint(x: .random(in: -500 ... 500 ), y: .random(in: -500 ... 500 ))
  }
}

struct CanvasView_Previews: PreviewProvider {
  static var previews: some View {
    CanvasView()
  }
}
