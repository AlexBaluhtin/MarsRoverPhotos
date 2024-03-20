//
//  RoverName.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

//enum RoverName: String, Decodable, CaseIterable, Identifiable {
//  var id: Self { self }
//  
//  case all         = "all"
//  case curiosity   = "curiosity"
//  case opportunity = "opportunity"
//  case spirit      = "spirit"
//}

enum RoverName: String, Decodable, CaseIterable, Identifiable {
  var id: Self { self }
  
  case curiosity = "curiosity"
  case opportunity = "opportunity"
  case spirit = "spirit"
  
  var cameras: [CameraIdentifier] {
    switch self {
    case .curiosity:
      return [.fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam]
    case .opportunity:
      return [.fhaz, .rhaz, .navcam, .pancam, .minites]
    case .spirit:
      return [.fhaz, .rhaz, .navcam, .pancam, .minites]
    }
  }
}
