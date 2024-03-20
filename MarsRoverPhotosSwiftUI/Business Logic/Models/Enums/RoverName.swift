//
//  RoverName.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

enum RoverName: String, Decodable, CaseIterable, Identifiable {
  var id: Self { self }
  
  case curiosity = "Curiosity"
  case opportunity = "Opportunity"
  case spirit = "Spirit"
  
  var cameras: [CameraIdentifier] {
    switch self {
    case .curiosity:
      return [.all, .fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam]
    case .opportunity:
      return [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]
    case .spirit:
      return [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]
    }
  }
}
