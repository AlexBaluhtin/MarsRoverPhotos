//
//  Camera.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

// MARK: - Camera
struct CameraModel: Codable {
  let id: Int
  let name: String
  let roverID: Int
  let fullName: String
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case roverID = "rover_id"
    case fullName = "full_name"
  }
}
