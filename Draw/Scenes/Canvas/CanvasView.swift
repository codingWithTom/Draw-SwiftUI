//
//  CanvasView.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct CanvasView: View {
  
  @ObservedObject private var viewModel = CanvasViewModel()
  @State private var isPresentingActionSheet = false
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.clear)
      TwoFingerGestureView(numberOfTaps: 2) {
        withAnimation {
          viewModel.removeAllShapes()
        }
      }
      ForEach(viewModel.shapes, id: \.id) { shape in
        AnyView(shape.shape())
          .onLongPressGesture {
            viewModel.selectedID = shape.id
            isPresentingActionSheet = true
          }
          .draggableAndScaleable()
          .transition(.modifier(
                        active: OffsetOpacityModifier(offset: getRandomOffset(), opacity: 0.0),
                        identity: OffsetOpacityModifier(offset: .zero, opacity: 1.0))
          )
      }
      if viewModel.isPresentingColorPicker {
        VStack {
          HStack {
            Button(action: { viewModel.dismissColorPicker() }, label: {
              Image(systemName: "multiply")
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 3, x: 0.0, y: 3)
            })
            Spacer()
          }
          ColorPicker("Choose Shape Color", selection: $viewModel.selectedColor)
          Spacer()
        }
        .padding()
      }
    }
    .contentShape(Rectangle())
    .onTapGesture(count: 2) {
      viewModel.addShape()
    }
    .actionSheet(isPresented: $isPresentingActionSheet, content: {
      ActionSheet(title: Text("Edit Shape"), message: nil, buttons: [
        .default(Text("Change Color"), action: { viewModel.isPresentingColorPicker = true }),
        .destructive(Text("Remove"), action: { withAnimation { viewModel.removeShape() } }),
        .cancel()
      ])
    })
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
