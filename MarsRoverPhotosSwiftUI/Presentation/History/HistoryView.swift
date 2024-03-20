//
//  HistoryView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI

struct HistoryView: View {
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(fetchRequest: FilterDataModel.all)
  
  var filters: FetchedResults<FilterDataModel>
  
  @ObservedObject var viewModel: HistoryViewModel = HistoryViewModel()
  
  @State private var isActionSheetPresented = false
  @State private var safeAreaInsetsTop: CGFloat = 0.0
  @Binding var filter: FilterModel
  
  var body: some View {
    VStack(spacing: 0) {
      createNavigationView()
      if filters.isEmpty {
        VStack {
          Spacer()
          Image(ConstantsImages.HistoryModule.empty.uiImage)
          Spacer()
        }
        Spacer()
      } else {
        createListImages()
      }
    }
    .navigationBarBackButtonHidden()
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      if let window = UIApplication.shared.windows.first {
        safeAreaInsetsTop = window.safeAreaInsets.top
      }
    }
  }
}

extension HistoryView {
  @ViewBuilder
  private func createListImages() -> some View {
    ScrollView {
      ForEach(filters, id: \.self) { filter in
        HistoryRowView(filter: filter)
          .offset(y: 20)
          .onTapGesture {
            viewModel.selectFilter(filter: filter)
            isActionSheetPresented.toggle()
          }
      }
    }
    
    .actionSheet(isPresented: $isActionSheetPresented) {
      ActionSheet(
        title: Text(""),
        message: Text(LocalizedStringKey(ConstantsStrings.HistoryModule.menuFilter.string)),
        buttons: [
          .default(Text(LocalizedStringKey(ConstantsStrings.HistoryModule.use.string)), action: {
            self.filter = viewModel.filter
            presentationMode.wrappedValue.dismiss()
          }),
          .destructive(Text(LocalizedStringKey(ConstantsStrings.HistoryModule.delete.string)), action: {
            viewModel.deleteFilter()
          }),
          .cancel()
        ]
      )
    }
    .frame(maxHeight: .infinity)
  }
}

extension HistoryView {
  @ViewBuilder
  private func createNavigationView() -> some View {
    HStack {
      Spacer()
      
      Text(LocalizedStringKey(ConstantsStrings.HistoryModule.title.string))
        .multilineTextAlignment(.center)
        .font(ConstantsFonts.sfProBold(34).font)
        .foregroundColor(.black)
      
      Spacer()
    }
    .overlay (
      HStack {
        
        Button {
          presentationMode.wrappedValue.dismiss()
        } label: {
          Image(ConstantsImages.HistoryModule.backButtonimage.uiImage)
            .padding(.leading, 16)
            .frame(width: 32, height: 32)
        }
        .frame(width: 44, height: 44)
        
        Spacer()
      }
    )
    .padding(.top, safeAreaInsetsTop + 20)
    .padding(.bottom, 21)
    .background(ConstantsColors.CommonColor.accentOne.uiColor)
  }
}

