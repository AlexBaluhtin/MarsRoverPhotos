//
//  Rover.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

struct RoverModel: Codable {
  let id: Int
  let name, landingDate, launchDate, status: String
  let maxSol: Int
  let maxDate: String
  let totalPhotos: Int
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case landingDate = "landing_date"
    case launchDate = "launch_date"
    case status
    case maxSol = "max_sol"
    case maxDate = "max_date"
    case totalPhotos = "total_photos"
  }
}
