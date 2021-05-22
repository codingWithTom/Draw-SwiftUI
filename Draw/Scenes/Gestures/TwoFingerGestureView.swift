//
//  TwoFingerGestureView.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-22.
//

import SwiftUI

struct TwoFingerGestureView: UIViewRepresentable {
  var numberOfTaps: Int = 1
  let onTap: () -> Void
  
  func makeCoordinator() -> TwoFingerGestureViewCoordinator {
    return TwoFingerGestureViewCoordinator(numberOfTaps: numberOfTaps, onTap: onTap)
  }
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    context.coordinator.addGestureToView(view)
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) { }
}

class TwoFingerGestureViewCoordinator {
  let onTap: () -> Void
  let numberOfTaps: Int
  
  init(numberOfTaps: Int, onTap: @escaping () -> Void) {
    self.numberOfTaps = numberOfTaps
    self.onTap = onTap
  }
  
  func addGestureToView(_ view: UIView) {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedWithTwoFingers))
    gesture.numberOfTouchesRequired = 2
    gesture.numberOfTapsRequired = numberOfTaps
    view.addGestureRecognizer(gesture)
  }
  
  @objc func tappedWithTwoFingers() {
    onTap()
  }
}
