//
//  CalendarView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 18/03/2024.
//

import SwiftUI

struct CalendarView: View {
  
  @State var isOpen: Bool = false
  @State var selectedDate: Date
  var closeCalendar: (() -> Void)?
  var closeAndSave: ((Date) -> Void)?
  
  var body: some View {
    VStack {
      Spacer()
      
      VStack {
        VStack {
          HStack {
            Button {
              closeCalendar?()
            } label: {
              Image(ConstantsImages.MainImages.closeDark.uiImage)
                .frame(width: 32, height: 32)
            }
            .padding(.leading, 26)
            .frame(width: 44, height: 44)
            
            Spacer()
            
            Text(LocalizedStringKey(ConstantsStrings.MainModule.date
              .string))
              .font(ConstantsFonts.sfProBold(22).font)
            
            Spacer()
            
            Button {
              closeAndSave?(selectedDate)
            } label: {
              Image(ConstantsImages.MainImages.tick.uiImage)
                .frame(width: 32, height: 32)
            }
            .padding(.trailing, 26)
            .frame(width: 44, height: 44)
          }
          
          DatePicker("",
                     selection: $selectedDate,
                     displayedComponents: [.date]
          )
          .datePickerStyle(.wheel)
          .labelsHidden()
        }
        .frame(height: 312)
        .background(Color.white)
        .cornerRadius(50)
        .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: -4)
        .padding(.horizontal, 20)
      }
      Spacer()
    }
    .opacity(isOpen ? 1 : 0)
    .onAppear(perform: {
        self.isOpen = true
    })
    .onDisappear(perform: { isOpen = false })
    .background(Color.black.opacity(0.5))
  }
}

//#Preview {
//  CalendarView()
//}
