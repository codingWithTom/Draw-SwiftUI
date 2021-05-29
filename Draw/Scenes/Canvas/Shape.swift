//
//  Shape.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct ShapeWrapper: Identifiable {
  let id = UUID()
  var color: Color
  let number: Int
  
  @ViewBuilder
  func shape() -> some View {
    if number == 1 {
      Circle()
        .fill(color)
        .frame(width: 100, height: 100)
    } else if number == 2 {
      Rectangle()
        .fill(color)
        .frame(width: 100, height: 100)
    } else if number == 3 {
      Rectangle()
        .fill(color)
        .frame(width: 150, height: 100)
    } else if number == 4 {
      Triangle()
        .fill(color)
        .frame(width: 150, height: 100)
    }
  }
  
  static func getRandomShape() -> ShapeWrapper {
    ShapeWrapper(color: getRandomColor(), number: Int.random(in: 1 ... 4))
  }
  
  static func getRandomColor() -> Color {
    [Color.blue, .purple, .orange, .red, .green, .yellow, .pink].randomElement() ?? .black
  }
}
