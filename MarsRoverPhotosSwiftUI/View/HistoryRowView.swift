//
//  HistoryRowView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import SwiftUI

struct HistoryRowView: View {
  @State private var isActionSheetPresented = false
  
  var filter: FilterDataModel
  
  var body: some View {
    HStack {
      HStack {
        VStack(alignment: .leading, spacing: 6) {
          HStack {
            Rectangle()
              .fill(ConstantsColors.CommonColor.accentOne.uiColor)
              .frame(maxWidth: .infinity, maxHeight: 1)
            
            Text(LocalizedStringKey(ConstantsStrings.HistoryModule.filters.string))
              .font(ConstantsFonts.sfProBold(22).font)
              .foregroundColor(ConstantsColors.CommonColor.accentOne.uiColor)
          }
          createTextTitleWithSubtitle(ConstantsStrings.HistoryModule.rover.string, filter.rover ?? "")
          createTextTitleWithSubtitle(ConstantsStrings.HistoryModule.camera.string, filter.camera ?? "")
          createTextTitleWithSubtitle(ConstantsStrings.HistoryModule.date.string, formatDate(filter.date ?? Date()))
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 16)
        
      }
      .padding(.trailing, 10)
      .background(Color.white)
      .cornerRadius(30)
      .shadow(color: Color.black.opacity(0.079), radius: 8, x: 0, y: 3)
    }
    .frame(maxHeight: .infinity)
    .padding(.horizontal, 16)
    
  }
  
  func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy"
    return dateFormatter.string(from: date)
  }
}

extension HistoryRowView {
  @ViewBuilder
  private func createTextTitleWithSubtitle(_ title: String, _ subTitle: String) -> some View {
    HStack(spacing: 10) {
      Text(LocalizedStringKey(title))
        .font(ConstantsFonts.sfPro(17).font)
        .foregroundColor(ConstantsColors.CommonColor.layerTwo.uiColor)
        
      Text(LocalizedStringKey(subTitle))
        .font(ConstantsFonts.sfProBold(17).font)
        .foregroundColor(ConstantsColors.CommonColor.layerOne.uiColor)
    }
    .padding(.trailing, 12)
    .padding(.leading, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
