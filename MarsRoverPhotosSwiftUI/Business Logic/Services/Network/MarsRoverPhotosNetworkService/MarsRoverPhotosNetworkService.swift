//
//  MarsRoverPhotosNetworkService.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation
import Combine

protocol MarsRoverPhotosServiceProtocol: AnyObject {
  var networker: NetworkerProtocol { get }
  
  func getMarsPhotos(rover: String, camera: String, date: String, page: Int) -> AnyPublisher<MarsPhoto, Error>
}

final class MarsRoverPhotosNetworkService: MarsRoverPhotosServiceProtocol {
  
  let networker: NetworkerProtocol
  
  init(networker: NetworkerProtocol = Networker()) {
    self.networker = networker
  }
  
  func getMarsPhotos(rover: String, camera: String, date: String, page: Int) -> AnyPublisher<MarsPhoto, Error> {
    let endpoint = Endpoint.roverPhotos(roverName: rover,
                                        camera: camera,
                                        earthDate: date,
                                        page: page)
    
    return networker.get(type: MarsPhoto.self,
                         url: endpoint.url,
                         headers: endpoint.headers)
  }
}
