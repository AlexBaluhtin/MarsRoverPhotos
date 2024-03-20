//
//  ConstantsStrings.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 14/03/2024.
//

import Foundation

enum ConstantsStrings {
  
  enum MainModule {
    case date
    case title
    case saveFilters
    case saveFiltersDescription
    case save
    case cancel
    case pleaseWait
    case titleRover
    case titleCamera
    case noPhotoAvailable
    
    var string: String {
      switch self {
      case .date:
        return  "MainModule.date"
      case .title:
        return "MainModule.navigationTitle"
      case .saveFilters:
        return "MainModule.saveFilters"
      case .saveFiltersDescription:
        return "MainModule.saveFiltersDescription"
      case .save:
        return "MainModule.save"
      case .cancel:
        return "MainModule.cancel"
      case .pleaseWait:
        return "MainModule.pleaseWait"
      case .titleRover:
        return "MainModule.titleRover"
      case .titleCamera:
        return "MainModule.titleCamera"
      case .noPhotoAvailable:
        return "MainModule.noPhotoAvailable"
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
