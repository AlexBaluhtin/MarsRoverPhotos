//
//  ConstantsImages.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 14/03/2024.
//

import SwiftUI

enum ConstantsImages {
  
  enum MainImages {
    case calendar
    case rover
    case camera
    case addPlus
    case history
    case tick
    case closeDark
    case closeLight
    
    var uiImage: String {
      switch self {
      case .calendar:
        return "Calendar"
      case .rover:
        return "Rover"
      case .camera:
        return "Camera"
      case .addPlus:
        return "addPlus"
      case .history:
        return "History"
      case .tick:
        return "Tick"
      case .closeDark:
        return "CloseDark"
      case .closeLight:
        return "CloseLight"
      }
    }
  }
  
  enum SpalshModule {
    case splashLogo
    
    var uiImage: String {
      switch self {
      case .splashLogo:
        return "splashImage"
      }
    }
  }
  
  enum HistoryModule {
    case backButtonimage
    case empty
    
    var uiImage: String {
      switch self {
      case .backButtonimage:
        return "Left"
      case .empty:
        return "Empty"
      }
    }
  }
}
