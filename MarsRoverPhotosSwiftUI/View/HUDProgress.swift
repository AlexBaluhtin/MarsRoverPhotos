//
//  HUDProgress.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 19/03/2024.
//

import SwiftUI

struct HUDProgress: View {
  
  var placeholder: LocalizedStringKey
  @Binding var show: Bool
  @State var animate = false
  
    var body: some View {
      VStack(spacing: 28) {
        Circle()
          .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
          .frame(width: 80, height: 80)
          .rotationEffect(.degrees(animate ? 360 : 0))
        
        Text(placeholder)
          .fontWeight(.bold)
          
      }
      .padding(.vertical, 25)
      .padding(.horizontal, 32)
      .background(BlurView())
      .cornerRadius(15)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        Color.primary.opacity(0.35)
          .onTapGesture {
            withAnimation {
              show.toggle()
            }
          }
      )
      .onAppear(perform: {
        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
          animate.toggle()
        }
      })
    }
}

