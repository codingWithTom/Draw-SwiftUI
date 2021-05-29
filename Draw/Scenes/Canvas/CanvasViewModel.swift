//
//  CanvasViewModel.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-26.
//

import Foundation
import SwiftUI

final class CanvasViewModel: ObservableObject {
  @Published var shapes: [ShapeWrapper] = []
  var selectedID: UUID?
  var selectedColor: Color = .clear {
    didSet {
      changeColorToShape()
    }
  }
  @Published var isPresentingColorPicker: Bool = false
  
  func addShape() {
    shapes.append(ShapeWrapper.getRandomShape())
  }
  
  func removeAllShapes() {
    shapes = []
  }
  
  func removeShape() {
    guard
      let selectedID = self.selectedID,
      let selectedIndex = shapes.firstIndex(where: { $0.id == selectedID })
    else { return }
    shapes.remove(at: selectedIndex)
    isPresentingColorPicker = false
  }
  
  func changeColorToShape() {
    guard
      let selectedID = self.selectedID,
      let selectedIndex = shapes.firstIndex(where: { $0.id == selectedID })
    else { return }
    var newShape = shapes[selectedIndex]
    newShape.color = selectedColor
    shapes[selectedIndex] = newShape
  }
  
  func dismissColorPicker() {
    isPresentingColorPicker = false
  }
  
}
