//
//  ConstantsColor.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 13/03/2024.
//

import SwiftUI

enum ConstantsColors {
  
  enum CommonColor {
    case backgroundOne
    case accentOne
    case layerOne
    case layerTwo
    case systemTwo
    case systemThree
    
    var uiColor: Color {
      switch self {
        
      case .backgroundOne:
        return Color(red: 0.94, green: 0.95, blue: 0.96)
      case .accentOne:
        return Color(red: 1.0, green: 0.41, blue: 0.17)
      case .layerOne:
        return Color(red: 0.0, green: 0.0, blue: 0.0)
      case .layerTwo:
        return Color(red: 0.63, green: 0.63, blue: 0.63)
      case .systemTwo:
        return Color(red: 0.0, green: 0.34, blue: 0.69)
      case .systemThree:
        return Color(red: 1.0, green: 0.23, blue: 0.19)
      }
    }
  }
}
