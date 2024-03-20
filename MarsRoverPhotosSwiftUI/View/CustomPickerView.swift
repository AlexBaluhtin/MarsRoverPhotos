//
//  CustomPickerView.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 18/03/2024.
//

import SwiftUI

struct CustomPickerView: UIViewRepresentable {
  let selection: Binding<DateDuration>
  let units: [String]
  
  func makeUIView(context: Context) -> UIPickerView {
    let pickerView = UIPickerView(frame: .zero)
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.delegate = context.coordinator
    pickerView.dataSource = context.coordinator
    return pickerView
  }
  
  func updateUIView(_ uiView: UIPickerView, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(selection: selection, units: units)
  }
  
  final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let selection: Binding<DateDuration>
    let units: [String]
    
    init(selection: Binding<DateDuration>, units: [String]) {
      self.selection = selection
      self.units = units
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return units.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(units[row])"
      
    }
  }
}

struct DateDuration {
  let unit: String = ""
}
