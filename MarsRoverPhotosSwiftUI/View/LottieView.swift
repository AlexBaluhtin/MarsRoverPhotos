//
//  LottieView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 13/03/2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
  
  var completion: (() -> Void)?
  
  func makeUIView(context: Context) -> some UIView {
    let view = UIView()
    let animationView = LottieAnimationView()
    let animation = LottieAnimation.named("lottieLoading")
    
    animationView.animation = animation
    animationView.loopMode = .repeat(2)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.contentMode = .scaleAspectFill
    animationView.clipsToBounds = true
    animationView.play { finished in
      if finished {
        self.completion?()
      }
    }
    
    view.addSubview(animationView)
    
    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}
