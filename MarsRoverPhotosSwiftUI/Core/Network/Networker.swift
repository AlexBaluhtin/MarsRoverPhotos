//
//  Networker.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 17/03/2024.
//

import Foundation
import Combine

protocol NetworkerProtocol: AnyObject {
  typealias Headers = [String: Any]
  
  func get<T>(type: T.Type,
              url: URL,
              headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
  
  func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError>
}

final class Networker: NetworkerProtocol {
  
  func get<T>(type: T.Type,
              url: URL,
              headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
    
    var urlRequest = URLRequest(url: url)
    
    headers.forEach { key, value in
      if let value = value as? String {
        urlRequest.setValue(value, forHTTPHeaderField: key)
      }
    }
    
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError> {
    
    var urlRequest = URLRequest(url: url)
    
    headers.forEach { key, value in
      if let value = value as? String {
        urlRequest.setValue(value, forHTTPHeaderField: key)
      }
    }
    
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
      .map(\.data)
      .eraseToAnyPublisher()
  }
}

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
  var url: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.nasa.gov"
    components.path = "/mars-photos/api/v1/rovers" + path
    components.queryItems = queryItems
    
    guard let url = components.url else {
      preconditionFailure("Invalid URL components: \(components)")
    }
    
    return url
  }
  
  var headers: [String: String] {
    return [:]
  }
}

extension Endpoint {
  
  static func roverPhotos(roverName: String, camera: String, earthDate: String, page: Int) -> Self {
    var queryItems = [
      URLQueryItem(name: "earth_date", value: earthDate),
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "api_key", value: "bGVDgxUlCCEfBSif4QImz9rVWeyM7eq1u0bFyVq1")
    ]
    
    // Проверяем, не равен ли параметр camera "all"
    if camera != "all" {
      queryItems.insert(URLQueryItem(name: "camera", value: camera), at: 1)
    }
    
    return Endpoint(path: "/\(roverName)/photos", queryItems: queryItems)
  }
}
