//
//  SplashView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI

struct SplashView: View {
  
  @State private var isShowingPhotos = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Spacer()
        
        Image(ConstantsImages.SpalshModule.splashLogo.uiImage)
          .shadow(color: Color(hex: "#000000", opacity: 0.1), radius: 10)
        
        VStack {
          Spacer()
          NavigationLink(destination: MainView(viewModel: MarsRoverPhotosViewModel(marsRoverPhotosService: MarsRoverPhotosNetworkService())), isActive: $isShowingPhotos) {
            
          }
          
          LottieView(completion: {
            isShowingPhotos.toggle()
          })
            .frame(width: 226, height: 68)
            .padding(.bottom, 114)
            .edgesIgnoringSafeArea(.bottom)
        }
      }
      
      .edgesIgnoringSafeArea(.all)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      
    }
    .navigationBarBackButtonHidden()
  }
}

#Preview {
    SplashView()
}
