//
//  BottomSheetView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 18/03/2024.
//

import SwiftUI

struct BottomSheetView: View {
  @Environment(\.presentationMode) var presentationMode
  
  let rows: [String]
  let title: String
  var onSelect: ((String) -> Void)
  @State var selectedRow: String = ""
  
  init(title: String, rows: [String], onSelect: @escaping ((String) -> Void)) {
    self.title = title
    self.rows = rows
    self.onSelect = onSelect
  }
  
  var body: some View {
    VStack {
      Spacer()
      
      VStack {
        HStack {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(ConstantsImages.MainImages.closeDark.uiImage)
              .frame(width: 32, height: 32)
          }
          .padding(.leading, 26)
          .frame(width: 44, height: 44)
          
          Spacer()
          
          Text(title)
            .font(ConstantsFonts.sfProBold(22).font)
          
          Spacer()
          
          Button {
            onSelect(selectedRow)
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(ConstantsImages.MainImages.tick.uiImage)
              .frame(width: 32, height: 32)
          }
          .padding(.trailing, 26)
          .frame(width: 44, height: 44)
        }
        .padding(.top, 26)
        
        //Spacer()
        
        Picker("", selection: $selectedRow) {
          ForEach(rows, id: \.self) { row in
            Text(row.capitalized)
              .font(selectedRow == row ? ConstantsFonts.sfProBold(22).font : ConstantsFonts.sfPro(22).font)
          }
        }
        .pickerStyle(.wheel)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: 306)
      .background(Color.white)
      .cornerRadius(50)
      .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: -4)
    }
    .onAppear(perform: {
      selectedRow = rows.first ?? ""
    })
    .edgesIgnoringSafeArea(.all)
    .background(Color.clear)
  }
}

struct ClearBackgroundView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    InnerView()
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
  }
  
  private class InnerView: UIView {
    override func didMoveToWindow() {
      super.didMoveToWindow()
      
      superview?.superview?.backgroundColor = .clear
    }
    
  }
}
