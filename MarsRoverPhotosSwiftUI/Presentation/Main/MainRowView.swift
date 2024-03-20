//
//  MainRowView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI

struct MainRowView: View {
  
  @ObservedObject private var viewModel: MainRowViewModel
  
  var isLast: Bool
  let photo: Photo
  var didTapRow: ((String) -> Void)
  @State var hero = false
  
  init(isLast: Bool, photo: Photo, didTapRow: @escaping ((String) -> Void)) {
    self.isLast = isLast
    self.viewModel = MainRowViewModel(urlString: photo.imgSrc)
    self.photo = photo
    self.didTapRow = didTapRow
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 6) {
        createTextTitleWithSubtitle("Rover:", photo.rover.name)
        createTextTitleWithSubtitle("Camera:", photo.camera.fullName)
        createTextTitleWithSubtitle("Date:", photo.earthDate)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 23)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
      
      Image(uiImage: viewModel.image ?? UIImage())
        .resizable()
        .scaledToFill()
        .frame(width: 130, height: 130)
        .cornerRadius(20)
        .padding(.trailing, 10)
      
    }
    .hideRowSeparator()
    .padding(.vertical, 10)
    //.padding(.trailing, 10)
    .background(Color.white)
    .cornerRadius(30)
    .shadow(color: Color.black.opacity(0.079), radius: 8, x: 0, y: 3)
    .onAppear(perform: {
      if isLast {
        print("Last cell appeared on screen")
      }
    })
    .onTapGesture {
      didTapRow(photo.imgSrc)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.horizontal, 16)
  }
}

extension MainRowView {
  @ViewBuilder
  private func createTextTitleWithSubtitle(_ title: String, _ subTitle: String) -> some View {
    HStack(spacing: 10) {
      Text(title)
        .font(ConstantsFonts.sfPro(17).font)
        .foregroundColor(ConstantsColors.CommonColor.layerTwo.uiColor)
      Text(subTitle)
        .font(ConstantsFonts.sfPro(17).font)
        .fontWeight(.bold)
        .foregroundColor(ConstantsColors.CommonColor.layerOne.uiColor)
    }
  }
}


//#Preview {
//    MainRowView()
//}
