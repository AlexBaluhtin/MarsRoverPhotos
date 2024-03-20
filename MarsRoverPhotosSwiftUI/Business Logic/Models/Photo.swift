//
//  Photo.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
  let id, sol: Int
  let camera: CameraModel
  let imgSrc: String
  let earthDate: String
  let rover: RoverModel
  
  enum CodingKeys: String, CodingKey {
    case id, sol, camera
    case imgSrc = "img_src"
    case earthDate = "earth_date"
    case rover
  }
}
