//
//  CameraName.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

enum CameraIdentifier: String, Decodable, CaseIterable, Identifiable {
  var id: Self { self }
  
  case all     = "all"
  case none    = "none"
  case entry   = "entry"
  case fhaz    = "fhaz"
  case rhaz    = "rhaz"
  case mast    = "mast"
  case chemcam = "chemcam"
  case mahli   = "mahli"
  case mardi   = "mardi"
  case navcam  = "navcam"
  case pancam  = "pancam"
  case minites = "minites"
}
