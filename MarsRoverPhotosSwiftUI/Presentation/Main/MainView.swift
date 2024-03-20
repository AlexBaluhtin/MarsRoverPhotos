//
//  MainView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI

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
  
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        createNavigationView()
        createListImages(photos: viewModel.photos)
      }
      .frame(maxWidth: .infinity)
      
      if isLoading {
        HUDProgress(placeholder: "Please Wait", show: $isLoading)
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
        title: Text("Save Filters"),
        message: Text("The current filters and the date you have chosen can be saved to the filter history."),
        primaryButton: .default(Text("Save")) {
          viewModel.saveFilter()
        },
        secondaryButton: .default(Text("Cancel")) {
          
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
            Text("MARS.CAMERA")
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
                viewModel.titleBottomSheet = "Rover"
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
                viewModel.titleBottomSheet = "Camera"
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
          .padding(.horizontal, 19)
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

//extension MainView {
//  @ViewBuilder
//  private func createListImages(photos: [Photo]) -> some View {
//    ScrollView {
//      ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
//        MainRowView(photo: photo, didTapRow: { photoString in
//          self.viewModel.saveSelectedImage(photoString)
//          isOpenFullIMage = true
//        })
//        .onAppear(perform: {
//          isLoading = false
////          if photo.id == photos.last?.id ?? 0 {
////            viewModel.onAppear()
////          }
//        })
//        .offset(y: 20)
//      }
//    }
////    .onRefresh(onValueChanged: { refreshControl in
////      
////    })
//    .compatibleFullScreen(isPresented: $isOpenFullIMage) {
//      FullImageView(viewModel: FullImageViewModel(urlString: self.viewModel.getSelectedImage()))
//    }
//    .background(Color.white)
//    .frame(maxHeight: .infinity)
//    
//  }
//}

extension MainView {
    @ViewBuilder
    private func createListImages(photos: [Photo]) -> some View {
      
        if photos.isEmpty {
          Spacer()
            Text("No photos available")
                .foregroundColor(.gray)
                .padding()
                .onAppear(perform: {
                    isLoading = false
                })
          Spacer()
        } else {
          List {
            ForEach(Array(photos.enumerated()), id: \.element.id) { index, photo in
              let isLast = index == photos.count - 1
              MainRowView(isLast: isLast, photo: photo, didTapRow: { photoString in
                self.viewModel.saveSelectedImage(photoString)
                isOpenFullIMage = true
                
              })
              .onAppear(perform: {
                if isLast {
                  viewModel.onAppear()
                }
              })
              .offset(y: 20)
              .listRowInsets(EdgeInsets())
            }
          }
            .listStyle(PlainListStyle())
            .onAppear(perform: {
                isLoading = false
            })
            .compatibleFullScreen(isPresented: $isOpenFullIMage) {
                FullImageView(viewModel: FullImageViewModel(urlString: self.viewModel.getSelectedImage()))
            }
            .background(Color.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(nil) // Отключить анимацию для корректного расчета высоты ячейки
            .modifier(DynamicListHeight())
        }
    }
}

//#Preview {
//  MainView(viewModel: MarsRoverPhotosViewModel())
//}

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
        //.opacity(0)
    } else {
      content.sheet(isPresented: isPresented, content: builder)
       // .opacity(0)
    }
  }
}

extension UIScrollView {
  
  struct Keys {
    static var onValueChanged: UInt8 = 0
  }
  
  public typealias ValueChangedAction = ((_ refreshControl: UIRefreshControl) -> Void)
  
  var onValueChanged: ValueChangedAction? {
    get {
      objc_getAssociatedObject(self, &Keys.onValueChanged) as? ValueChangedAction
    }
    set {
      objc_setAssociatedObject(self, &Keys.onValueChanged, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  public func onRefresh(_ onValueChanged: @escaping ValueChangedAction) {
    if refreshControl == nil {
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(
           self,
           action: #selector(self.onValueChangedAction),
           for: .valueChanged
         )
      self.refreshControl = refreshControl
    }
    self.onValueChanged = onValueChanged
  }
  
  @objc func onValueChangedAction(sender: UIRefreshControl) {
    self.onValueChanged?(sender)
  }
}


//struct OnListRefreshModifier: ViewModifier {
//  
//  let onValueChanged: UIScrollView.ValueChangedAction
//  
//  func body(content: Content) -> some View {
//    content
//      .introspect(.scrollView, on: .iOS(.v13, .v14, .v15)) { scrollView in
//        scrollView.onRefresh(onValueChanged)
//      }
//  }
//}


//public extension View {
//  
//  func onRefresh(onValueChanged: @escaping UIScrollView.ValueChangedAction) -> some View {
//    self.modifier(OnListRefreshModifier(onValueChanged: onValueChanged))
//  }
//}

extension View {
    func hideRowSeparator(insets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                          background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}

struct HideRowSeparatorModifier: ViewModifier {

  static let defaultListRowHeight: CGFloat = 44

  var insets: EdgeInsets
  var background: Color

  init(insets: EdgeInsets, background: Color) {
    self.insets = insets

    var alpha: CGFloat = 0
    if #available(iOS 14.0, *) {
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
    }
    self.background = background
  }

  func body(content: Content) -> some View {
    content
        .padding(insets)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: Self.defaultListRowHeight)
        .listRowInsets(EdgeInsets())
        .overlay(
            VStack {
                HStack {}
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
                Spacer()
                HStack {}
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
            }
            .padding(.top, -1)
        )
  }
}

struct DynamicListHeight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ListHeightPreferenceKey.self) { listHeight in
                UITableView.appearance().contentInset.bottom = listHeight // Установить высоту контента в зависимости от высоты списка
            }
    }
}

struct ListHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
