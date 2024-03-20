//
//  ConstantsStrings.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 14/03/2024.
//

import Foundation

enum ConstantsStrings {
  
  enum MainModule {
    case home
    case chat
    var string: String {
      switch self {
      case .home:
        return "TabBar.home"
      case .chat:
        return "TabBar.chat"
      }
    }
  }
  
  enum HistoryModule {
    case title
    case filters
    case rover
    case camera
    case date
    case menuFilter
    case use
    case delete
    case cancel
    
    var string: String {
      switch self {
      case .title:
        return "HistoryModule.navigationTitle"
      case .filters:
        return "HistoryModule.filters"
      case .rover:
        return "HistoryModule.rover"
      case .camera:
        return "HistoryModule.camera"
      case .date:
        return "HistoryModule.date"
      case .menuFilter:
        return "HistoryModule.menuFilter"
      case .use:
        return "HistoryModule.use"
      case .delete:
        return "HistoryModule.delete"
      case .cancel:
        return "HistoryModule.cancel"
      }
    }
  }
}
