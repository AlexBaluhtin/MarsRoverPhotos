//
//  CameraName.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

enum CameraIdentifier: String, Decodable, CaseIterable, Identifiable {
  var id: Self { self }
  
  case all     = "All"
  case none    = "none"
  case entry   = "Entry"
  case fhaz    = "Fhaz"
  case rhaz    = "Rhaz"
  case mast    = "Mast"
  case chemcam = "Chemcam"
  case mahli   = "Mahli"
  case mardi   = "Mardi"
  case navcam  = "Navcam"
  case pancam  = "Pancam"
  case minites = "Minites"
}
