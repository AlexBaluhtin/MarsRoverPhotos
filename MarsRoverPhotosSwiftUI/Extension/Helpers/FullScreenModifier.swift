//
//  FullScreenModifier.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import SwiftUI

extension View {
  func compatibleFullScreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
    self.modifier(FullScreenModifier(isPresented: isPresented, builder: content))
  }
}

struct FullScreenModifier<V: View>: ViewModifier {
  let isPresented: Binding<Bool>
  let builder: () -> V
  
  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOS 14.0, *) {
      content.fullScreenCover(isPresented: isPresented, content: builder)
    } else {
      content.sheet(isPresented: isPresented, content: builder)
    }
  }
}
