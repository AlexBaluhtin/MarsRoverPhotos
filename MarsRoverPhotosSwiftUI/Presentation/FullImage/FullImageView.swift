//
//  FullImageView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 18/03/2024.
//

import SwiftUI

struct FullImageView: View {
  // MARK: - PROPERTY
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject var viewModel: FullImageViewModel
  
  @State private var safeAreaInsetsTop: CGFloat = 0.0
  @State private var isAnimating: Bool = false
  @State private var imageScale: CGFloat = 1
  @State private var imageOffset: CGSize = CGSize.zero
  @State private var isDrawerOpen: Bool = false
  
  @State private var pageIndex: Int = 1
  
  init(viewModel: FullImageViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - FUNCTION
  func resetImageState() {
    
    return withAnimation(.spring()){
      imageScale = 1
      imageOffset = .zero
      
    }
  }
  
  // MARK: - CONTENT
  
  var body: some View {
      
      ZStack {
        Color.black
        VStack {
          HStack {
            Button {
              presentationMode.wrappedValue.dismiss()
            } label: {
              Image(ConstantsImages.MainImages.closeLight.uiImage)
                .frame(width: 44, height: 44)
            }
            Spacer()
          }
          Spacer()
        }
        .padding(.top, safeAreaInsetsTop + 20)
        .padding(.leading, 20)
        .frame(alignment: .topLeading)
        
        // MARK: - PAGE IMAGE
        Image(uiImage: viewModel.image ?? UIImage())
          .resizable()
          .aspectRatio(contentMode: .fit)
          .shadow(color: .black.opacity(0.2), radius: 12, x:2, y: 2)
          .opacity(isAnimating ? 1: 0)
          .animation(.linear(duration: 0.5), value: isAnimating)
          .offset(x: imageOffset.width, y: imageOffset.height)
          .scaleEffect(imageScale)
        
        //MARE: - 1. TAP GESTURE
          .onTapGesture(count: 2) {
            if imageScale == 1 {
              withAnimation(.spring()){
                imageScale = 5
                
              }
            }else{
              resetImageState()
              
            }
          }//: TAP GESTURE
        //MARK: - 2. DRAG GESTURE
          .gesture(DragGesture()
            .onChanged{ value in
              withAnimation(.linear(duration: 0.5)){
                if imageScale <= 1  {
                  imageOffset = value.translation
                }else{
                  imageOffset = value.translation
                  
                }
                
                
              }
            }
            .onEnded{ value in
              if imageScale <= 1 {
                resetImageState()
              }
              
              
            }
          )//: DRAG GESTURE
        // MARK: - 3. MAGIFICATION
          .gesture(
            MagnificationGesture()
              .onChanged{ value in
                withAnimation(.linear(duration: 0.5)){
                  if imageScale >= 1 && imageScale <= 5 {
                    imageScale = value
                  } else if imageScale > 5 {
                    imageScale = 5
                  }
                }
              }
              .onEnded{ _ in
                
                if imageScale > 5 {
                  imageScale = 5
                } else if imageScale <= 1 {
                  resetImageState()
                }
              }
            
            
          )
        
      }
      .onAppear {
        if let window = UIApplication.shared.windows.first {
          safeAreaInsetsTop = window.safeAreaInsets.top
        }
      }
      .edgesIgnoringSafeArea(.all)
      .onAppear {
        withAnimation(.linear(duration: 0.5)){
          isAnimating = true
        }
      }
      
      // MARK: - CONTROLS
      .overlay(
        Group{
          HStack{
            // SCALE DOWN
            Button{
              withAnimation(.spring()){
                if imageScale > 1 {
                  imageScale -= 1
                  
                  if imageScale <= 1 {
                    resetImageState()
                  }
                }
              }
            } label: {}
            
            // RESET
            Button{
              resetImageState()
            } label: {}
            
            // SCALE UP
            Button{
              withAnimation(.spring()){
                if imageScale < 5 {
                  imageScale += 1
                  
                  if imageScale > 5 {
                    imageScale = 5
                  }
                }
              }
            } label: {}
            
          }//: HSTACK
          .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
          .cornerRadius(12)
          .opacity(isAnimating ? 1 : 0)
          
        }
          .padding(.bottom, 30)
        , alignment: .bottom
      )
    .onTapGesture(count: 3) {
      if(imageScale > 1){
        resetImageState()
      }
    }
  }
}

//#Preview {
//  FullImageView()
//}
