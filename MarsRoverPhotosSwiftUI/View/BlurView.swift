//
//  BlurView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 19/03/2024.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> some UIView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
  
}
