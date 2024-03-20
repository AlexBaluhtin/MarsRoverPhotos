//
//  MainView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI
import SwiftUIIntrospect

struct MainView: View {
  @ObservedObject var viewModel: MarsRoverPhotosViewModel
  
  @State private var selectedImage: String = ""
  @State private var isOpenFullIMage: Bool = false
  @State private var safeAreaInsetsTop: CGFloat = 0.0
  @State private var isOpenBottomSheet = false
  @State private var isOpenHistory = false
  @State private var isFirstOpen = false
  @State var titleBottomSheet: String = ""
  @State var isLoading = false
  @State var isOpenAlertSaveFilter = false
  @State var isRefreshing: Bool = false
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        createNavigationView()
        createListImages(photos: viewModel.photos)
      }
      .frame(maxWidth: .infinity)
      
      if isLoading {
        HUDProgress(placeholder: LocalizedStringKey(ConstantsStrings.MainModule.pleaseWait.string), show: $isLoading)
      }
      
      if viewModel.isOpenCalendar {
        CalendarView(selectedDate: viewModel.filter.date,
                     closeCalendar: {
          withAnimation {
            viewModel.changeStatusCalendar()
          }
        }, closeAndSave: { date in
          viewModel.filter.date = date
          viewModel.setDate(date)
          withAnimation {
            viewModel.changeStatusCalendar()
          }
        })
        .background(ClearBackgroundView())
        .edgesIgnoringSafeArea(.all)
      }
      
      NavigationLink(destination: HistoryView(filter: $viewModel.filter), isActive: $isOpenHistory) {}
    }
    .alert(isPresented: $isOpenAlertSaveFilter) {
      Alert(
        title: Text(LocalizedStringKey(ConstantsStrings.MainModule.saveFilters.string)),
        message: Text(LocalizedStringKey(ConstantsStrings.MainModule.saveFiltersDescription.string)),
        primaryButton: .default(Text(LocalizedStringKey(ConstantsStrings.MainModule.save.string))) {
          viewModel.saveFilter()
        },
        secondaryButton: .default(Text(LocalizedStringKey(ConstantsStrings.MainModule.cancel.string))) {
          
        }
      )
    }
    .edgesIgnoringSafeArea(.all)
    .navigationBarBackButtonHidden()
    .onAppear(perform: {
      UITableView.appearance().separatorStyle = .none
      isLoading = true
      if !isFirstOpen {
        isFirstOpen = true
        viewModel.onAppear()
      }
    })
    .overlay(
      VStack {
        Spacer()
        HStack {
          Spacer()
          createHistoryButton()
        }
      }
    )
    .compatibleFullScreen(isPresented: $isOpenBottomSheet) {
      BottomSheetView(title: viewModel.titleBottomSheet,
                      rows: viewModel.getRowsToBottomSheet(), onSelect: { selectedRow in
        switch viewModel.selecterBottomSheetFilter {
        case .rover:
          viewModel.setRover(RoverName(rawValue: selectedRow) ?? .curiosity)
        case .camera:
          viewModel.setCamera(CameraIdentifier(rawValue: selectedRow) ?? .all)
        }
      })
      .background(ClearBackgroundView())
    }
    .onAppear {
      if let window = UIApplication.shared.windows.first {
        safeAreaInsetsTop = window.safeAreaInsets.top
      }
    }
    .edgesIgnoringSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy"
    return dateFormatter.string(from: date)
  }
}

extension MainView {
  @ViewBuilder
  private func createNavigationView() -> some View {
    
    HStack {
      VStack {
        HStack {
          VStack(alignment: .leading) {
            Text(LocalizedStringKey(ConstantsStrings.MainModule.title.string))
              .font(.largeTitle)
              .fontWeight(.bold)
            Text(formatDate(viewModel.filter.date))
              .font(.body)
              .fontWeight(.bold)
          }
          Spacer()
          VStack {
            Button {
              withAnimation {
                viewModel.changeStatusCalendar()
              }
            } label: {
              Image(ConstantsImages.MainImages.calendar.uiImage)
            }
          }
        }
        .padding(.leading, 19)
        .padding(.trailing, 17)
        
        HStack {
          HStack {
            HStack(spacing: 12) {
              Button {
                viewModel.selectBottomSheetFilter(filter: .rover)
                viewModel.titleBottomSheet = LocalizedStringKey(ConstantsStrings.MainModule.titleRover.string)
                isOpenBottomSheet.toggle()
              } label: {
                ZStack {
                  RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 144, height: 38)
                  HStack {
                    
                    Image(ConstantsImages.MainImages.rover.uiImage)
                      .padding(.leading, 11)
                    
                    Text(viewModel.filter.rover.rawValue)
                      .font(.body)
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                    Spacer()
                  }
                }
                
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
              }
              
              Button {
                viewModel.selectBottomSheetFilter(filter: .camera)
                viewModel.titleBottomSheet = LocalizedStringKey(ConstantsStrings.MainModule.titleCamera.string)
                isOpenBottomSheet.toggle()
              } label: {
                ZStack {
                  RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 144, height: 38)
                  HStack {
                    Image(ConstantsImages.MainImages.camera.uiImage)
                      .padding(.leading, 11)
                    
                    Text(viewModel.filter.camera.rawValue)
                      .font(.body)
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                    Spacer()
                  }
                }
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
              }
              
            }
            Spacer()
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 38, height: 38)
              Image(ConstantsImages.MainImages.addPlus.uiImage)
            }
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            .onTapGesture {
              isOpenAlertSaveFilter.toggle()
            }
          }
          .padding(.horizontal, 20)
        }
      }
      Spacer()
    }
    .padding(.bottom, 15)
    .padding(.top, safeAreaInsetsTop)
    .background(ConstantsColors.CommonColor.accentOne.uiColor)
    .shadow(color: Color.black.opacity(0.05), radius: 8.5, x: 0, y: 6)
  }
}

extension MainView {
  @ViewBuilder
  private func createHistoryButton() -> some View {
    
    ZStack {
      Circle()
        .fill(ConstantsColors.CommonColor.accentOne.uiColor)
      Image(ConstantsImages.MainImages.history.uiImage)
        .resizable()
        .frame(width: 32, height: 32)
    }
    .onTapGesture {
      isOpenHistory.toggle()
    }
    .padding(.trailing, 20)
    .padding(.bottom, 20)
    .frame(width: 70, height: 70)
  }
}

extension MainView {
  @ViewBuilder
  private func createListImages(photos: [Photo]) -> some View {
    
    if photos.isEmpty {
      Spacer()
      Text(LocalizedStringKey(ConstantsStrings.MainModule.noPhotoAvailable.string))
        .foregroundColor(.gray)
        .padding()
        .onAppear(perform: {
          isLoading = false
        })
      Spacer()
    } else {
      MyList {
        ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
          let isLast = index == photos.count - 1
          MainRowView(isLast: isLast, photo: photo, didTapRow: { photoString in
            self.viewModel.saveSelectedImage(photoString)
            isOpenFullIMage = true
            
          })
          .onAppear(perform: {
            isLoading = false
            if isLast {
              viewModel.onAppear()
            }
          })
          .offset(y: 20)
        }
        
      }
      .padding(.bottom, 48)
      .compatibleFullScreen(isPresented: $isOpenFullIMage) {
        FullImageView(viewModel: FullImageViewModel(urlString: self.viewModel.getSelectedImage()))
      }
      .background(Color.white)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

//#Preview {
//  MainView(viewModel: MarsRoverPhotosViewModel())
//}



