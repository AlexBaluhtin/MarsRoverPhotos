//
//  FullImageViewModel.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 19/03/2024.
//

import SwiftUI

class FullImageViewModel: ObservableObject {
  
  @Published var image: UIImage?
  
  private var imageCache: NSCache<NSString, UIImage>?
  
  init(urlString: String?) {
    loadImage(urlString: urlString)
  }
  
  private func loadImage(urlString: String?) {
    guard let urlString = urlString else { return }
    
    if let imageFromCache = getImageCache(from: urlString) {
      image = imageFromCache
      return
    }
    
    loadImageFromUrl(urlString: urlString)
  }
  
  private func loadImageFromUrl(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else {
        print(error ?? "unknown error")
        return
      }
      
      guard let data = data else {
        print("No data")
        return
      }
      
      DispatchQueue.main.sync { [weak self] in
        guard let loadedImage = UIImage(data: data) else { return }
        self?.image = loadedImage
        self?.setImageCache(image: loadedImage, key: urlString)
      }
    }.resume()
  }
  
  private func setImageCache(image: UIImage, key: String) {
    imageCache?.setObject(image, forKey: key as NSString)
  }

  private func getImageCache(from key: String) -> UIImage? {
    return imageCache?.object(forKey: key as NSString) as? UIImage
  }
  
}
