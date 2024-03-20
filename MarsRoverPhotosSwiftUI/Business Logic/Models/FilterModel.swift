//
//  FilterModel.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import Foundation
import CoreData

struct FilterModel: Identifiable, Hashable {
  var id: UUID
  var rover: RoverName = .curiosity
  var camera: CameraIdentifier = .all
  var date = Date()
}

extension FilterDataModel: Model {
  
}
